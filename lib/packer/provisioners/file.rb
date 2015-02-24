# Encoding: utf-8
require 'packer/provisioner'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    class File < Provisioner
      def initialize
        super
        self.data['type'] = FILE
        self.add_required('source', 'destination')
      end

      def source(filename)
        self.__add_string('source', filename)
      end

      def destination(filename)
        self.__add_string('destination', filename)
      end
    end
  end
end
