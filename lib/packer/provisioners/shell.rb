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
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Shell < Provisioner
      def initialize
        super
        self.data['type'] = SHELL
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