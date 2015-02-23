require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class Puppet < Provisioner
      class Server < Puppet
        def initialize
          super
          self.data['type'] = PUPPET_SERVER
        end

        def client_cert_path(path)
          self.__add_string('client_cert_path', path)
        end

        def client_private_key_path(path)
          self.__add_string('client_private_key_path', path)
        end

        def facter(facts)
          self.__add_hash('facter', facts)
        end

        def options(opts)
          self.__add_string('options', opts)
        end

        def prevent_sudo(flag)
          self.__add_boolean('prevent_sudo', flag)
        end

        def puppet_node(nodename)
          self.__add_string('puppet_node', nodename)
        end

        def puppet_server(servername)
          self.__add_string('puppet_server', servername)
        end

        def staging_directory(dirname)
          self.__add_string('staging_directory', dirname)
        end
      end
    end
  end
end