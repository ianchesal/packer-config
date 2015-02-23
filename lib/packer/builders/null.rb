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
    class Null < Builder
      def initialize
        super
        self.data['type'] = NULL
        self.add_required(
          'host',
          'ssh_password',
          'ssh_private_key_file',
          'ssh_username'
        )
      end

      def host(name)
        self.__add_string('host', name)
      end

      def ssh_password(passwd)
        self.__add_string('ssh_password', passwd)
      end

      def ssh_private_key_file(filename)
        self.__add_string('ssh_private_key_file', filename)
      end

      def ssh_username(name)
        self.__add_string('ssh_username', name)
      end

      def port(number)
        self.__add_integer('port', number)
      end
    end
  end
end
