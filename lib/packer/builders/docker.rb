# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class Docker < Builder
      def initialize
        super
        self.data['type'] = DOCKER
        self.add_required(
          'export_path',
          'image'
        )
      end

      def export_path(path)
        self.__add_string('export_path', path)
      end

      def image(name)
        self.__add_string('image', name)
      end

      def pull(bool)
        self.__add_boolean('pull', bool)
      end

      def run_command(commands)
        self.__add_array_of_strings('run_command', commands)
      end
    end
  end
end