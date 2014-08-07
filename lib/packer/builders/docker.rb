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