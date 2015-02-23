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
    class Salt < Provisioner
      def initialize
        super
        self.data['type'] = SALT
        self.add_required(['local_state_tree'])
      end

      def bootstrap_args(args)
        self.__add_string('bootstrap_args', args)
      end

      def local_pillar_roots(dirname)
        self.__add_string('local_pillar_roots', dirname)
      end

      def local_state_tree(dirname)
        self.__add_string('local_state_tree', dirname)
      end

      def minion_config(filename)
        self.__add_string('minion_config', filename)
      end

      def temp_config_dir(dirname)
        self.__add_string('temp_config_dir', dirname)
      end

      def skip_bootstrap(bool)
        self.__add_boolean('skip_bootstrap', bool)
      end
    end
  end
end
