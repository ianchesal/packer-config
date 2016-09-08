# Encoding: utf-8
require 'json'
require 'packer/runner'
require 'packer/dataobject'
require 'packer/builder'
require 'packer/provisioner'
require 'packer/postprocessor'
require 'packer/macro'
require 'packer/envvar'
require 'packer/version'
require 'rubygems/dependency'

module Packer
  class Config < Packer::DataObject
    attr_accessor :builders
    attr_accessor :postprocessors
    attr_accessor :provisioners
    attr_accessor :packer
    attr_accessor :packer_options
    attr_reader   :macro
    attr_reader   :envvar
    attr_reader   :output_file

    PACKER_VERSION = '0.9.0'

    def initialize(file)
      super()
      self.data['variables'] = {}
      self.output_file = file
      self.builders = []
      self.provisioners = []
      self.postprocessors = []
      self.packer = 'packer'
      self.packer_options = []
      self.macro = Macro.new
      self.envvar = EnvVar.new
    end

    def validate
      super
      verify_packer_version
      if self.builders.empty?
        raise DataValidationError.new("At least one builder is required")
      end
      self.builders.each(&:validate)
      self.provisioners.each(&:validate)
      self.postprocessors.each(&:validate)
      self.write
      stdout = nil
      Dir.chdir(File.dirname(self.output_file)) do
        begin
          stdout = Packer::Runner.run! self.packer, 'validate', File.basename(self.output_file), quiet: true
        rescue Packer::Runner::CommandExecutionError => e
          raise PackerBuildError.new(e.to_s)
        end
      end
      self.delete
      stdout
    end

    class DumpError < StandardError
    end

    def dump(format='json', pretty=false)
      data_copy = self.deep_copy
      data_copy['builders'] = []
      self.builders.each do |thing|
        data_copy['builders'].push(thing.deep_copy)
      end
      unless self.provisioners.empty?
        data_copy['provisioners'] = []
        self.provisioners.each do |thing|
          data_copy['provisioners'].push(thing.deep_copy)
        end
      end
      unless self.postprocessors.empty?
        data_copy['post-processors'] = []
        self.postprocessors.each do |thing|
          data_copy['post-processors'].push(thing.deep_copy)
        end
      end
      case format
      when 'json'
        if pretty
          JSON.pretty_generate(data_copy)
        else
          data_copy.to_json
        end
      else
        raise DumpError.new("Unrecognized format #{format} use one of ['json']")
      end
    end

    def write(format='json')
      File.write(self.output_file, self.dump(format))
    end

    def delete
      File.delete(self.output_file)
    end

    class PackerBuildError < StandardError
    end

    def build(quiet: false)
      self.validate
      self.write
      stdout = nil
      Dir.chdir(File.dirname(self.output_file)) do
        begin
          stdout = Packer::Runner.run! self.packer, 'build', self.packer_options, File.basename(self.output_file), quiet: quiet
        rescue Packer::Runner::CommandExecutionError => e
          raise PackerBuildError.new(e.to_s)
        end
      end
      self.delete
      stdout
    end

    def description(description)
      self.__add_string('description', description)
    end

    def variables
      self.data['variables']
    end

    def add_builder(type)
      builder = Packer::Builder.get_builder(type)
      self.builders.push(builder)
      builder
    end

    def add_provisioner(type)
      provisioner = Packer::Provisioner.get_provisioner(type)
      self.provisioners.push(provisioner)
      provisioner
    end

    def add_postprocessor(type)
      postprocessor = Packer::PostProcessor.get_postprocessor(type)
      self.postprocessors.push(postprocessor)
      postprocessor
    end

    def add_variable(name, value)
      variables_copy = Marshal.load(Marshal.dump(self.variables))
      variables_copy[name.to_s] = value.to_s
      self.__add_hash('variables', variables_copy)
    end

    class UndefinedVariableError < StandardError
    end

    def variable(name)
      unless self.variables.key? name
        raise UndefinedVariableError.new("No variable named #{name} has been defined -- did you forget to call add_variable?")
      end
      "{{user `#{name}`}}"
    end

    def verify_packer_version
      min_packer_version PACKER_VERSION
      version = /Packer v(\d+\.\d+\.\d+)/.match(
        Packer::Runner.run!(packer, 'version', quiet: true)
      )[1]
      Gem::Dependency.new('', ">= #{PACKER_VERSION}").match?('', version) || raise("Packer version #{version} is not new enough (requires >= #{PACKER_VERSION})")
    end

    def min_packer_version(version)
      self.__add_string('min_packer_version', version)
    end

    private

    attr_writer :output_file
    attr_writer :macro
    attr_writer :envvar
  end
end
