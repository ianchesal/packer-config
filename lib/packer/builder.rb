# Encoding: utf-8
require 'packer/builders/all'

module Packer
  class Builder

    VALID_BUILDER_TYPES = %w[
      amazon-ebs
      amazon-instance
      docker
      virtualbox-iso
    ]

    class UnrecognizedBuilderType < StandardError
    end

    def self.get_builder(type)
      unless validate_type(type)
        raise UnrecognizedBuilderType.new("Unrecognized builder type #{type}")
      end
      {
        'amazon-ebs' => Packer::Builder::Amazon::EBS,
        'amazon-instance' => Packer::Builder::Amazon::Instance,
        'docker' => Packer::Builder::Docker,
        'virtualbox-iso' => Packer::Builder::VirtualBox::ISO
      }.fetch(type).new
    end

    attr_accessor :data

    def initialize
      self.data = {}
    end

    private
    def self.validate_type(type)
      VALID_BUILDER_TYPES.include? type
    end
  end
end