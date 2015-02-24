# Encoding: utf-8
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
