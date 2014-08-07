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

  describe '#variable' do
    it 'creates a packer reference to a variable in the configuration' do
      expect(packer.variables).to eq({})
      packer.add_variable('key1', 'value1')
      expect(packer.variable 'key1').to eq('{{user `key1`}}')
      packer.data['variables'] = {}
    end

    it 'raises an error when the variable has not been defined in the configuration' do
      expect(packer.variables).to eq({})
      expect { packer.variable 'key1' }.to raise_error(Packer::Config::UndefinedVariableError)
      packer.data['variables'] = {}
    end
  end

  describe '#envvar' do
    it 'creates a packer reference to an environment variable' do
      expect(packer.envvar 'TEST').to eq('{{env `TEST`}}')
    end
  end

  describe '#macro' do
    it 'creates a packer macro reference' do
      expect(packer.macro 'Var').to eq('{{ .Var }}')
    end
  end

end