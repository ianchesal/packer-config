# Encoding: utf-8
require 'packer/postprocessors/all'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    DOCKER_IMPORT = 'docker-import'
    DOCKER_PUSH = 'docker-push'
    DOCKER_SAVE = 'docker-save'
    DOCKER_TAG = 'docker-tag'
    VAGRANT = 'vagrant'
    COMPRESS = 'compress'
    SHELL_LOCAL = 'shell-local'

    VALID_POST_PROCESSOR_TYPES = [
      DOCKER_IMPORT,
      DOCKER_PUSH,
      DOCKER_SAVE,
      DOCKER_TAG,
      COMPRESS,
      VAGRANT,
      SHELL_LOCAL
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
        DOCKER_SAVE   => Packer::PostProcessor::DockerSave,
        DOCKER_TAG    => Packer::PostProcessor::DockerTag,
        COMPRESS      => Packer::PostProcessor::Compress,
        SHELL_LOCAL   => Packer::PostProcessor::ShellLocal,
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
      unless self.data.key? 'only'
        self.data['only'] = []
      end
      self.data['only'] << buildname.to_s
    end

    def except(buildname)
      unless self.data.key? 'except'
        self.data['except'] = []
      end
      self.data['except'] << buildname.to_s
    end

    def keep_input_artifact(bool)
      self.__add_boolean('keep_input_artifact', bool)
    end

    def self.validate_type(type)
      VALID_POST_PROCESSOR_TYPES.include? type
    end

    private_class_method :validate_type
  end
end
