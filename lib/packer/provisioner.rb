# Encoding: utf-8
require 'packer/provisioners/all'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    SHELL             = 'shell'
    FILE              = 'file'
    SALT              = 'salt-masterless'
    ANSIBLE           = 'ansible-local'
    CHEF_CLIENT       = 'chef-client'
    CHEF_SOLO         = 'chef-solo'
    PUPPET_MASTERLESS = 'puppet-masterless'
    PUPPET_SERVER     = 'puppet-server'
    WINDOWS_RESTART   = 'windows-restart'

    VALID_PROVISIONER_TYPES = [
      SHELL,
      FILE,
      SALT,
      ANSIBLE,
      CHEF_CLIENT,
      CHEF_SOLO,
      PUPPET_MASTERLESS,
      PUPPET_SERVER,
      WINDOWS_RESTART
    ]

    class UnrecognizedProvisionerTypeError < StandardError
    end

    def self.get_provisioner(type)
      unless validate_type(type)
        raise UnrecognizedProvisionerTypeError.new("Unrecognized provisioner type #{type}")
      end
      {
        SHELL             => Packer::Provisioner::Shell,
        FILE              => Packer::Provisioner::File,
        SALT              => Packer::Provisioner::Salt,
        ANSIBLE           => Packer::Provisioner::Ansible,
        CHEF_CLIENT       => Packer::Provisioner::Chef::Client,
        CHEF_SOLO         => Packer::Provisioner::Chef::Solo,
        PUPPET_MASTERLESS => Packer::Provisioner::Puppet::Masterless,
        PUPPET_SERVER     => Packer::Provisioner::Puppet::Server,
        WINDOWS_RESTART   => Packer::Provisioner::WindowsRestart
      }.fetch(type).new
    end

    def self.types
      VALID_PROVISIONER_TYPES
    end

    def initialize
      super
      self.add_required('type')
    end

    def only(buildname)
      unless self.data.has_key? 'only'
        self.data['only'] = []
      end
      self.data['only'] << buildname.to_s
    end

    def except(buildname)
      unless self.data.has_key? 'except'
        self.data['except'] = []
      end
      self.data['except'] << buildname.to_s
    end

    def pause_before(duration)
      self.data["pause_before"] = duration.to_s
    end

    def override(builddefinition, values)
      raise TypeError.new() unless values.is_a?(Hash)
      unless self.data.has_key? 'override'
        self.data['override'] = {}
      end
      if self.data.has_key? @data['override'][builddefinition]
        self.data['override'][builddefinition].merge! values
      else
        self.data['override'][builddefinition] = values
      end
    end

    private
    def self.validate_type(type)
      VALID_PROVISIONER_TYPES.include? type
    end
  end
end