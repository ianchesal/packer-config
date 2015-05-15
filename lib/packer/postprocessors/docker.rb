# Encoding: utf-8
require 'packer/postprocessor'
require 'packer/dataobject'

module Packer
  class PostProcessor < Packer::DataObject
    class DockerImport < PostProcessor
      def initialize
        super
        self.data['type'] = DOCKER_IMPORT
        self.add_required('repository')
      end

      def repository(repo)
        self.__add_string('repository', repo)
      end

      def tag(tag)
        self.__add_string('tag', tag)
      end
    end

    class DockerPush < PostProcessor
      def initialize
        super
        self.data['type'] = DOCKER_PUSH
      end

      def login(bool)
        self.__add_boolean('login', bool)
      end

      def login_email(email)
        self.__add_string('login_email', email)
      end

      def login_username(username)
        self.__add_string('login_username', username)
      end

      def login_password(password)
        self.__add_string('login_password', password)
      end

      def login_server(server)
        self.__add_string('login_server', server)
      end
    end

    class DockerSave < PostProcessor
      def initialize
        super
        self.data['type'] = DOCKER_SAVE
        self.add_required('path')
      end

      def path(path)
        self.__add_string('path', path)
      end
    end

    class DockerTag < PostProcessor
      def initialize
        super
        self.data['type'] = DOCKER_TAG
        self.add_required('repository')
      end

      def repository(repo)
        self.__add_string('repository', repo)
      end

      def tag(tag)
        self.__add_string('tag', tag)
      end
    end
  end
end
