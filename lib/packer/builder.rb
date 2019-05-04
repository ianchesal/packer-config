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
    QEMU            = 'qemu'
    NULL            = 'null'

    VALID_BUILDER_TYPES = [
      AMAZON_EBS,
      AMAZON_INSTANCE,
      DOCKER,
      VIRTUALBOX_ISO,
      VMWARE_VMX,
      VMWARE_ISO,
      QEMU,
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
        QEMU            => Packer::Builder::Qemu,
        NULL            => Packer::Builder::Null
      }.fetch(type).new
    end

    attr_reader :communicators

    def self.types
      VALID_BUILDER_TYPES
    end

    def initialize
      super
      self.add_required('type')
      self.communicators = []
    end

    def name(name)
      self.__add_string('name', name)
    end

    # @ianchesal: Communicators are technically Templates in Packer land but
    # they modify Builders. Weird. So we'll treat them as Builder attributes.
    # See: https://packer.io/docs/templates/communicator.html
    def communicator(comm)
      raise(DataValidationError, "unknown communicator protocol #{comm}") unless communicators.include? comm

      self.__add_string('communicator', comm)
    end

    # Technically these only apply if the communicator is ssh
    def ssh_host(host)
      self.__add_string('ssh_host', host)
    end

    def ssh_port(port)
      self.__add_integer('ssh_port', port)
    end

    def ssh_username(username)
      self.__add_string('ssh_username', username)
    end

    def ssh_password(password)
      self.__add_string('ssh_password', password)
    end

    def ssh_private_key_file(filename)
      self.__add_string('ssh_private_key_file', filename)
    end

    def ssh_pty(pty)
      self.__add_boolean('ssh_pty', pty)
    end

    def ssh_timeout(timeout)
      self.__add_string('ssh_timeout', timeout)
    end

    def ssh_handshake_attempts(attempts)
      self.__add_integer('ssh_handshake_attempts', attempts)
    end

    def ssh_disable_agent(disable)
      self.__add_boolean('ssh_disable_agent', disable)
    end

    def ssh_bastion_host(hostname)
      self.__add_string('ssh_bastion_host', hostname)
    end

    def ssh_bastion_username(username)
      self.__add_string('ssh_bastion_username', username)
    end

    def ssh_bastion_password(password)
      self.__add_string('ssh_bastion_password', password)
    end

    def ssh_bastion_private_key_file(filename)
      self.__add_string('ssh_bastion_private_key_file', filename)
    end

    # Technically these only apply if the communicator is winrm
    def winrm_host(host)
      self.__add_string('winrm_host', host)
    end

    def winrm_port(port)
      self.__add_string('winrm_port', port)
    end

    def winrm_username(username)
      self.__add_string('winrm_username', username)
    end

    def winrm_password(password)
      self.__add_string('winrm_password', password)
    end

    def winrm_timeout(timeout)
      self.__add_string('winrm_timeout', timeout)
    end

    private

    attr_writer :communicators

    def self.validate_type(type)
      VALID_BUILDER_TYPES.include? type
    end

    private_class_method :validate_type
  end
end
