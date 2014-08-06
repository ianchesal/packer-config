# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class DockerImport < PostProcessor
      def initialize
        super()
        self.data['type'] = DOCKER_IMPORT
      end
    end

    class DockerPush < PostProcessor
      def initialize
        super()
        self.data['type'] = DOCKER_PUSH
      end
    end
  end
end