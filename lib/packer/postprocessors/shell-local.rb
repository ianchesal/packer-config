# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class ShellLocal < PostProcessor
      def initialize
        super
        self.data['type'] = SHELL_LOCAL
        self.add_required(['inline', 'script', 'scripts'])
      end
      def inline(commands)
        self.__add_array_of_strings('inline', commands, %w[script scripts])
      end

      def script(filename)
        self.__add_string('script', filename, %w[inline scripts])
      end

      def scripts(filenames)
        self.__add_array_of_strings('scripts', filenames, %w[inline script])
      end

      def binary(bool)
        self.__add_boolean('binary', bool, [])
      end

      def environment_vars(envpairs)
        self.__add_array_of_strings('environment_vars', envpairs)
      end

      def execute_command(command)
        self.__add_string('execute_command', command)
      end

      def inline_shebang(command)
        self.__add_string('inline_shebang', command)
      end

      def remote_path(command)
        self.__add_string('remote_path', command)
      end
    end
  end
end
