# Encoding: utf-8

module Packer
  class DataObject

    attr_accessor :data

    def initialize
      self.data = {}
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

    def __add_string(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      self.data[key.to_s] = data.to_s
    end

    def __add_integer(key, data, exclusives = [])
      self.__exclusive_key_error(key, exclusives)
      self.data[key.to_s] = data.to_i
    end

    def __add_boolean(key, bool, exclusives = [])
      if bool
        self.data[key.to_s] = true
      else
        self.data[key.to_s] = false
      end
    end
  end
end
