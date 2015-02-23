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

RSpec.describe Packer::Provisioner::Ansible do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('ansible-local')
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

  it 'requires a playbook_file setting' do
    expect{ provisioner.validate }.to raise_error
  end

  describe '#initialize' do
    it 'has a type of ansible-local' do
      expect(provisioner.data['type']).to eq('ansible-local')
    end
  end

  describe '#playbook_file' do
    it 'accepts a string' do
      provisioner.playbook_file some_string
      expect(provisioner.data['playbook_file']).to eq(some_string)
      provisioner.data.delete('playbook_file')
    end

    it 'converts any argument passed to a string' do
      provisioner.playbook_file some_array_of_ints
      expect(provisioner.data['playbook_file']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('playbook_file')
    end
  end
end
