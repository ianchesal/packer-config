# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class Vagrant < PostProcessor
      def initialize
        super()
        self.data['type'] = VAGRANT
      end

      def compression_level(level)
        self.__add_integer('compression_level', level)
      end

      def include(files)
        self.__add_array_of_strings('include', files)
      end

      def keep_input_artifact(bool)
        self.__add_boolean('keep_input_artifact', bool)
      end

      def output(file)
        self.__add_string('output', file)
      end

      def vagrantfile_template(file)
        self.__add_string('vagrantfile_template', file)
      end
    end
  end
end
