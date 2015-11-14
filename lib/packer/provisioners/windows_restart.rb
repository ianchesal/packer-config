# Encoding: utf-8
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class WindowsRestart < Provisioner
      def initialize
        super
        self.data['type'] = WINDOWS_RESTART
      end

      def restart_command(command)
        self.__add_string('restart_command', command)
      end

      def restart_check_command(command)
        self.__add_string('restart_check_command', command)
      end

      def restart_timeout(timeout)
        self.__add_string('restart_timeout', timeout)
      end
    end
  end
end
