# Encoding: utf-8
require 'json'
require 'yaml'
require 'packer/dataobject'
require 'packer/builder'
require 'packer/provisioner'
require 'packer/postprocessor'

module Packer
  class Config < Packer::DataObject

    attr_accessor :builders
    attr_accessor :postprocessors
    attr_accessor :provisioners
    attr_accessor :variables
    attr_reader   :output_file

    def initialize(file)
      super()
      self.output_file = file
      self.data['builders'] = []
      self.data['postprocessors'] = []
      self.data['provisioners'] = []
      self.data['variables'] = {}
      self.add_required('builders')
    end

    def validate
      super
      self.builders.each do |thing|
        thing.validate
      end
      self.provisioners.each do |thing|
        thing.validate
      end
      self.postprocessors.each do |thing|
        thing.validate
      end
    end

    class DumpError < StandardError
    end

    def dump(format='json')
      data_copy = Marshal.load(Marshal.dump(self.data))
      ['postprocessors', 'provisioners', 'variables'].each do |optional|
        data_copy.delete(optional) if data_copy[optional].empty?
      end
      case format
      when 'json'
        data_copy.to_json
      when 'yaml', 'yml'
        data_copy.to_yaml
      else
        raise DumpError.new("Unrecognized format #{format} use one of ['json', 'yaml']")
      end
    end

    def write(format='json')
      File.write(self.output_file, self.dump(format))
    end

    def description(description)
      self.__add_string('description', description)
    end

    def min_packer_version(version)
      self.__add_string('min_packer_version', version)
    end

    def builders
      self.data['builders']
    end

    def provisioners
      self.data['provisioners']
    end

    def postprocessors
      self.data['postprocessors']
    end

    def variables
      self.data['variables']
    end

    def add_builder(type)
      builder = Packer::Builder.get_builder(type)
      self.builders.append(builder)
      builder
    end

    def add_provisioner(type)
      provisioner = Packer::Provisioner.get_provisioner(type)
      self.provisioners.append(provisioner)
      provisioner
    end

    def add_postprocessor(type)
      postprocessor = Packer::PostProcessor.get_postprocessor(type)
      self.postprocessors.append(postprocessor)
      postprocessor
    end

    def add_variable(name, value)
      variables_copy = Marshal.load(Marshal.dump(self.variables))
      variables_copy[name.to_s] = value.to_s
      self.__add_hash('variables', variables_copy)
    end

    class UndefinedVariableError < StandardError
    end

    def ref_variable(name)
      unless self.variables.has_key? name
        raise UndefinedVariableError.new("No variable named #{name} has been defined -- did you forget to call add_variable?")
      end
      "{{user `#{name}`}}"
    end

    def ref_envvar(name)
      "{{env `#{name}`}}"
    end

    def macro(name)
      "{{ .#{name} }}"
    end

    private
    attr_writer :output_file

  end
end
