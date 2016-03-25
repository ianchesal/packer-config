# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class Compress < PostProcessor
      def initialize
        super()
        self.data['type'] = COMPRESS
      end

      def compression_level(level)
        self.__add_integer('compression_level', level)
      end

      def keep_input_artifact(bool)
        self.__add_boolean('keep_input_artifact', bool)
      end

      def output(file)
        self.__add_string('output', file)
      end
    end
  end
end
