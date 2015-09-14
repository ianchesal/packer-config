# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class Null < Builder
      def initialize
        super
        self.data['type'] = NULL
        self.communicators = %w(none ssh winrm)
      end
    end
  end
end
