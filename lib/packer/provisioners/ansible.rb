# Encoding: utf-8
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Ansible < Provisioner
      def initialize
        super
        self.data['type'] = ANSIBLE
        self.add_required(['playbook_file'])
      end

      def playbook_file(filename)
        self.__add_string('playbook_file', filename)
      end

      def command(cmd)
        self.__add_string('command', cmd)
      end

      def extra_arguments(args)
        self.__add_array_of_strings('extra_arguments', args)
      end

      def inventory_file(filename)
        self.__add_string('inventory_file', filename)
      end

      def playbook_dir(dirname)
        self.__add_string('playbook_dir', dirname)
      end

      def playbook_paths(paths)
        self.__add_array_of_strings('playbook_paths', paths)
      end

      def group_vars(vars)
        self.__add_string('group_vars', vars)
      end

      def host_vars(vars)
        self.__add_string('host_vars', vars)
      end

      def role_paths(paths)
        self.__add_array_of_strings('role_paths', paths)
      end

      def staging_directory(dirname)
        self._add_string('staging_directory', dirname)
      end
    end
  end
end
