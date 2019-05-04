# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class Manifest < PostProcessor
      def initialize
        super
        self.data['type'] = MANIFEST
      end

      def output(file)
        self.__add_string('output', file)
      end

      def strip_path(bool)
        self.__add_boolean('strip_path', bool)
      end

      def custom_data(data)
        self.__add_hash('custom_data', data)
      end
    end
  end
end
