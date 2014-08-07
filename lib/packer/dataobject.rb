# Encoding: utf-8
# Copyright 2014 Ian Chesal
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

module Packer
  class DataObject

    attr_accessor :data
    attr_accessor :required

    def initialize
      self.data = {}
      self.required = []
    end

    class DataValidationError < StandardError
    end

    def validate
      self.required.each do |r|
        if (r.is_a? Array) && (r.length > 0)
          if r.length - (r - self.data.keys).length == 0
            raise DataValidationError.new("Missing one required setting from the set #{r}")
          end
          if r.length - (r - self.data.keys).length > 1
            raise DataValidationError.new("Found more than one exclusive setting in data from set #{r}")
          end
        else
          if ! self.data.keys.include? r
            raise DataValidationError.new("Missing required setting #{r}")
          end
        end
      end
      # TODO(ianc) Also validate the data with the packer command?
      true
    end

    def add_required(*keys)
      keys.each do |k|
        self.required.push(k)
      end
    end

    def deep_copy
      Marshal.load(Marshal.dump(self.data))
    end

    class ExclusiveKeyError < StandardError
    end

    def __exclusive_key_error(key, exclusives)
      exclusives.each do |e|
        if self.data.has_key? e
          raise ExclusiveKeyError.new("Only one of #{exclusives} can be used at a time")
        end
      end
      true
    end

    def __add_array_of_strings(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = values.to_ary.map{ |c| c.to_s }
    end

    def __add_array_of_array_of_strings(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = []
      values.each do |v|
        raise TypeError.new() unless Array.try_convert(v)
        self.data[key.to_s].push(v.to_ary.map{ |c| c.to_s })
      end
    end

    def __add_array_of_hashes(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = []
      values.each do |v|
        raise TypeError.new() unless v.is_a?(Hash)
        self.data[key.to_s].push({})
        v.keys.each do |k|
          self.data[key.to_s][-1][k] = v[k].to_s
        end
      end
    end

    def __add_string(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      self.data[key.to_s] = data.to_s
    end

    def __add_integer(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      self.data[key.to_s] = data.to_i
    end

    def __add_boolean(key, bool, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      if bool
        self.data[key.to_s] = true
      else
        self.data[key.to_s] = false
      end
    end

    def __add_hash(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless data.is_a?(Hash)
      self.data[key.to_s] = {}
      data.keys.each do |k|
        self.data[key.to_s][k] = data[k].to_s
      end
    end
  end
end
