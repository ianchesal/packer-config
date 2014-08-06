# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class Amazon < Builder
      class EBS < Amazon
      end

      class Instance < Amazon
      end
    end
  end
end