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