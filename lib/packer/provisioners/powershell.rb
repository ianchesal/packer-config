# Encoding: utf-8
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Powershell < Provisioner
      def initialize
        super
        self.data['type'] = POWERSHELL
        self.add_required(['inline', 'script', 'scripts'])
        self.add_key_dependencies({
            'elevated_user' => ['elevated_password'],
            'elevated_password' => ['elevated_user']
        })
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

      def remote_path(command)
        self.__add_string('remote_path', command)
      end

      def start_retry_timeout(time)
        self.__add_string('start_retry_timeout', string)
      end

      def valid_exit_codes(codes)
        self.__add_array_of_ints('valid_exit_codes', codes)
      end

      def elevated_user(user)
        self.__add_string('elevated_user', user)
      end

      def elevated_password(password)
        self.__add_string('elevated_password', password)
      end
    end
  end
end
