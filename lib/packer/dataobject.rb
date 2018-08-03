# Encoding: utf-8
module Packer
  class DataObject
    attr_accessor :data
    attr_accessor :required
    attr_accessor :key_dependencies

    def initialize
      self.data = {}
      self.required = []
      self.key_dependencies = {}
    end

    class DataValidationError < StandardError
    end

    def validate
      validate_required
      validate_key_dependencies

      # TODO(ianc) Also validate the data with the packer command?
      true
    end

    def validate_required
      self.required.each do |r|
        if (r.is_a? Array) && !r.empty?
          if (r.length - (r - self.data.keys).length).zero?
            raise DataValidationError.new("Missing one required setting from the set #{r}")
          end
          if r.length - (r - self.data.keys).length > 1
            raise DataValidationError.new("Found more than one exclusive setting in data from set #{r}")
          end
        elsif ! self.data.key? r
          raise DataValidationError.new("Missing required setting #{r}")
        end
      end
    end

    def validate_key_dependencies
      self.data.keys.each do |data_key|
        next unless self.key_dependencies.key? data_key
        unless (self.key_dependencies[data_key] - self.data.keys).empty?
          raise DataValidationError.new("Key #{data_key} requires that keys be defined: #{self.key_dependencies[data_key]}")
        end
      end
    end

    def add_required(*keys)
      keys.each do |k|
        self.required.push(k)
      end
    end

    def add_key_dependencies(key_deps)
      self.key_dependencies.merge!(key_deps)
    end

    def deep_copy
      Marshal.load(Marshal.dump(self.data))
    end

    class ExclusiveKeyError < StandardError
    end

    def __exclusive_key_error(key, exclusives)
      exclusives.each do |e|
        if self.data.key? e
          raise ExclusiveKeyError.new("Only one of #{exclusives} can be used at a time")
        end
      end
      true
    end

    def __add_array_of_strings(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = values.to_ary.map(&:to_s)
    end

    def __add_array_of_array_of_strings(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = []
      values.each do |v|
        raise TypeError.new() unless Array.try_convert(v)
        self.data[key.to_s].push(v.to_ary.map(&:to_s))
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

    def __add_array_of_ints(key, values, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless Array.try_convert(values)
      self.data[key.to_s] = values.to_ary.map(&:to_i)
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
      self.data[key.to_s] = bool ? true : false
    end

    def __add_hash(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless data.is_a?(Hash)
      self.data[key.to_s] = {}
      data.keys.each do |k|
        self.data[key.to_s][k] = data[k].to_s
      end
    end


    def __add_json(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      raise TypeError.new() unless data.is_a?(Hash)
      self.data[key.to_s] = {}
      data.keys.each do |k|
        self.data[key.to_s][k] = data[k]
      end
    end
  end
end
