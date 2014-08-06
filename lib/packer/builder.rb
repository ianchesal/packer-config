# Encoding: utf-8
require 'packer/builders/all'

module Packer
  class Builder < DataObject

    AMAZON_EBS      = 'amazon-ebs'
    AMAZON_INSTANCE = 'amazon-instance'
    DOCKER          = 'docker'
    VIRTUALBOX_ISO  = 'virtualbox-iso'

    VALID_BUILDER_TYPES = [
      AMAZON_EBS,
      AMAZON_INSTANCE,
      DOCKER,
      VIRTUALBOX_ISO
    ]

    class UnrecognizedBuilderTypeError < StandardError
    end

    def self.get_builder(type)
      unless validate_type(type)
        raise UnrecognizedBuilderTypeError.new("Unrecognized builder type #{type}")
      end
      {
        AMAZON_EBS      => Packer::Builder::Amazon::EBS,
        AMAZON_INSTANCE => Packer::Builder::Amazon::Instance,
        DOCKER          => Packer::Builder::Docker,
        VIRTUALBOX_ISO  => Packer::Builder::VirtualBox::ISO
      }.fetch(type).new
    end

    def self.types
      VALID_BUILDER_TYPES
    end

    private
    def self.validate_type(type)
      VALID_BUILDER_TYPES.include? type
    end
  end
end