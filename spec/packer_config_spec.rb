# Encoding: utf-8
require 'spec_helper'
require 'fakefs/safe'

RSpec.describe Packer::Config do
  let(:packer) { Packer::Config.new('config.json') }

  describe '#initialize' do
    it 'returns an instance' do
      expect(packer).to be_a_kind_of(Packer::Config)
    end
  end

  describe '#add_variable' do
    it 'adds a new variable key/value pair' do
      expect(packer.variables).to eq({})
      packer.add_variable('key1', 'value1')
      expect(packer.variables).to eq({'key1' => 'value1'})
      packer.add_variable('key2', 'value2')
      expect(packer.variables).to eq({'key1' => 'value1', 'key2' => 'value2'})
      packer.data['variables'] = {}
    end
  end

  describe '#ref_variable' do
    it 'creates a packer reference to a variable in the configuration' do
      expect(packer.variables).to eq({})
      packer.add_variable('key1', 'value1')
      expect(packer.ref_variable 'key1').to eq('{{user `key1`}}')
      packer.data['variables'] = {}
    end

    it 'raises an error when the variable has not been defined in the configuration' do
      expect(packer.variables).to eq({})
      expect { packer.ref_variable 'key1' }.to raise_error(Packer::Config::UndefinedVariableError)
      packer.data['variables'] = {}
    end
  end

  describe '#ref_envvar' do
    it 'creates a packer reference to an environment variable' do
      expect(packer.ref_envvar 'TEST').to eq('{{env `TEST`}}')
    end
  end

  describe '#macro' do
    it 'creates a packer macro reference' do
      expect(packer.macro 'Var').to eq('{{ .Var }}')
    end
  end

end