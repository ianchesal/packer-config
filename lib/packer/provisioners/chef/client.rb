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
    class Chef < Provisioner
      class Client < Chef
        def initialize
          super
          self.data['type'] = CHEF_CLIENT
          self.add_required(['server_url'])
        end

        def server_url(url)
          self.__add_string('server_url', url)
        end

        def chef_environment(env)
          self.__add_string('chef_environment', env)
        end

        def config_template(filename)
          self.__add_string('config_template', filename)
        end

        def execute_command(command)
          self.__add_string('execute_command', command)
        end

        def install_command(command)
          self.__add_string('install_command', command)
        end

        # TODO How to support json?

        def node_name(name)
          self.__add_string('node_name', name)
        end

        def prevent_sudo(bool)
          self.__add_boolean('prevent_sudo', bool)
        end

        def run_list(list)
          self.__add_array_of_strings('run_list', list)
        end

        def skip_clean_client(bool)
          self.__add_bool('skip_clean_client', bool)
        end

        def skip_clean_node(bool)
          self.__add_bool('skip_clean_node', bool)
        end

        def skip_install(bool)
          self.__add_bool('skip_install', bool)
        end

        def staging_directory(dirname)
          self.__add_string('staging_directory', dirname)
        end

        def validation_client_name(name)
          self.__add_string('validation_client_name', name)
        end

        def validation_key_path(path)
          self.__add_string('validation_key_path', path)
        end
      end
    end
  end
end
