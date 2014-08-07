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
    class File < Provisioner
      def initialize
        super
        self.data['type'] = FILE
        self.add_required('source', 'destination')
      end

      def source(filename)
        self.__add_string('source', filename)
      end

      def destination(filename)
        self.__add_string('destination', filename)
      end
    end
  end
end