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

RSpec.describe Packer::Provisioner::File do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('file')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of file' do
      expect(provisioner.data['type']).to eq('file')
    end
  end

  describe '#source' do
    it 'accepts a string' do
      provisioner.source(some_string)
      expect(provisioner.data['source']).to eq(some_string)
      provisioner.data.delete('source')
    end

    it 'converts any argument passed to a string' do
      provisioner.source(some_array_of_ints)
      expect(provisioner.data['source']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('source')
    end
  end

  describe '#destination' do
    it 'accepts a string' do
      provisioner.destination(some_string)
      expect(provisioner.data['destination']).to eq(some_string)
      provisioner.data.delete('destination')
    end

    it 'converts any argument passed to a string' do
      provisioner.destination(some_array_of_ints)
      expect(provisioner.data['destination']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('destination')
    end
  end
end