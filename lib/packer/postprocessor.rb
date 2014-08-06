# Encoding: utf-8
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