require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Puppet < Provisioner
      class Masterless < Puppet
        def initialize
          super
          self.data['type'] = PUPPET_MASTERLESS
          self.add_required(['manifest_file'])
        end

        def manifest_file(filename)
          self.__add_string('manifest_file', filename)
        end

        def execute_command(command)
          self.__add_string('execute_command', command)
        end

        def facter(facts)
          self.__add_hash('facter', facts)
        end

        def hiera_config_path(path)
          self.__add_string('hiera_config_path', path)
        end

        def manifest_dir(path)
          self.__add_string('manifest_dir', path)
        end

        def module_paths(paths)
          self.__add_array_of_strings('module_paths',paths)
        end

        def prevent_sudo(flag)
          self.__add_boolean('prevent_sudo', flag)
        end

        def staging_directory(dirname)
          self.__add_string('staging_directory', dirname)
        end
      end
    end
  end
end