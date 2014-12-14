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
require 'packer/postprocessors/all'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    DOCKER_IMPORT = 'docker-import'
    DOCKER_PUSH = 'docker-push'
    VAGRANT = 'vagrant'

    VALID_POST_PROCESSOR_TYPES = [
      DOCKER_IMPORT,
      DOCKER_PUSH,
      VAGRANT
    ]

    class UnrecognizedPostProcessorTypeError < StandardError
    end

    def self.get_postprocessor(type)
      unless validate_type(type)
        raise UnrecognizedPostProcessorTypeError.new("Unrecognized post-processor type #{type}")
      end
      {
        DOCKER_IMPORT => Packer::PostProcessor::DockerImport,
        DOCKER_PUSH   => Packer::PostProcessor::DockerPush,
        VAGRANT       => Packer::PostProcessor::Vagrant
      }.fetch(type).new
    end

    def self.types
      VALID_POST_PROCESSOR_TYPES
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

    def keep_input_artifact(bool)
      self.__add_boolean('keep_input_artifact', bool)
    end

    private
    def self.validate_type(type)
      VALID_POST_PROCESSOR_TYPES.include? type
    end
  end
end
