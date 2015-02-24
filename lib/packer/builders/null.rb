# Encoding: utf-8
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
