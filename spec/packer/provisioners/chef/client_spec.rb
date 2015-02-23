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

RSpec.describe Packer::Provisioner::Chef::Client do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('chef-client')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_strings) do
    %w[commmand1 command2]
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  let(:some_hash_of_strings) do
    {a: 'foo', b: 'bar'}
  end

  it 'requires a server_url setting' do
    expect{ provisioner.validate }.to raise_error
  end

  describe '#initialize' do
    it 'has a type of chef-client' do
      expect(provisioner.data['type']).to eq('chef-client')
    end
  end

  describe '#server_url' do
    it 'accepts a string' do
      provisioner.server_url some_string
      expect(provisioner.data['server_url']).to eq(some_string)
      provisioner.data.delete('server_url')
    end

    it 'converts any argument passed to a string' do
      provisioner.server_url some_array_of_ints
      expect(provisioner.data['server_url']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('server_url')
    end
  end

  describe '#run_list' do
    it 'accepts an array of strings' do
      provisioner.run_list(some_array_of_strings)
      expect(provisioner.data['run_list']).to eq(some_array_of_strings)
      provisioner.data.delete('run_list')
    end

    it 'converts all entities to strings' do
      provisioner.run_list(some_array_of_ints)
      expect(provisioner.data['run_list']).to eq(some_array_of_ints.map(&:to_s))
      provisioner.data.delete('run_list')
    end

    it 'raises an error if the argument cannot be made an Array' do
      expect { provisioner.run_list(some_string) }.to raise_error
    end
  end
end
