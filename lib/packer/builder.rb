# Encoding: utf-8
require 'packer/builders/all'

module Packer
  class Builder < DataObject
    AMAZON_EBS      = 'amazon-ebs'
    AMAZON_INSTANCE = 'amazon-instance'
    DOCKER          = 'docker'
    VIRTUALBOX_ISO  = 'virtualbox-iso'
    VMWARE_VMX      = 'vmware-vmx'
    VMWARE_ISO      = 'vmware-iso'
    NULL            = 'null'

    VALID_BUILDER_TYPES = [
      AMAZON_EBS,
      AMAZON_INSTANCE,
      DOCKER,
      VIRTUALBOX_ISO,
      VMWARE_VMX,
      VMWARE_ISO,
      NULL
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
        VIRTUALBOX_ISO  => Packer::Builder::VirtualBoxISO,
        VMWARE_VMX      => Packer::Builder::VMWareVMX,
        VMWARE_ISO      => Packer::Builder::VMWareISO,
        NULL            => Packer::Builder::Null
      }.fetch(type).new
    end

    def self.types
      VALID_BUILDER_TYPES
    end

    def initialize
      super
      self.add_required('type')
    end

    def name(name)
      self.__add_string('name', name)
    end

    private
    def self.validate_type(type)
      VALID_BUILDER_TYPES.include? type
    end
  end
end
