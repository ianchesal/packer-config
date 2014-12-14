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
require 'packer/provisioners/all'
require 'packer/dataobject'

module Packer
  class Provisioner < Packer::DataObject
    SHELL = 'shell'
    FILE = 'file'

    VALID_PROVISIONER_TYPES = [
      SHELL,
      FILE
    ]

    class UnrecognizedProvisionerTypeError < StandardError
    end

    def self.get_provisioner(type)
      unless validate_type(type)
        raise UnrecognizedProvisionerTypeError.new("Unrecognized provisioner type #{type}")
      end
      {
        SHELL => Packer::Provisioner::Shell,
        FILE  => Packer::Provisioner::File,
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
