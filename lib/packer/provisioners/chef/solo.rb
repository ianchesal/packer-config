# Encoding: utf-8
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Chef < Provisioner
      class Solo < Chef
        def initialize
          super
          self.data['type'] = CHEF_SOLO
          self.add_required([])
        end

        def config_template(filename)
          self.__add_string('config_template', filename)
        end

        def cookbook_paths(paths)
          self.__add_array_of_strings('cookbook_paths', paths)
        end

        def data_bags_path(path)
          self.__add_string('data_bags_path', path)
        end

        def encrypted_data_bag_secret_path(path)
          self.__add_string('encrypted_data_bag_secret_path', path)
        end

        def execute_command(command)
          self.__add_string('execute_command', command)
        end

        def install_command(command)
          self.__add_string('install_command', command)
        end

        # TODO How to handle json?

        def prevent_sudo(bool)
          self.__add_boolean('prevent_sudo', bool)
        end

        def remote_cookbook_paths(paths)
          self.__add_array_of_strings('remote_cookbook_paths', paths)
        end

        def roles_path(path)
          self.__add_string('roles_path', path)
        end

        def run_list(runlist)
          self.__add_array_of_strings('run_list', runlist)
        end

        def skip_install(bool)
          self.__add_boolean('skip_install', bool)
        end

        def staging_directory(dirname)
          self.__add_string('staging_directory', dirname)
        end
      end
    end
  end
end
