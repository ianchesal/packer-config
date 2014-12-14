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
        VIRTUALBOX_ISO  => Packer::Builder::VirtualBoxISO
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
