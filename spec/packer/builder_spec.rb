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

RSpec.describe Packer::Builder do
  VALID_BUILDER_TYPE = Packer::Builder::VIRTUALBOX_ISO

  let(:builder) { Packer::Builder.new }

  describe '.get_builder' do
    it 'returns a builder' do
      expect(Packer::Builder.get_builder(VALID_BUILDER_TYPE)).to be_a_kind_of(Packer::Builder)
    end

    it 'raises an error when the builder type is not recognized' do
      expect { Packer::Builder.get_builder('unknown-type') }.to raise_error(Packer::Builder::UnrecognizedBuilderTypeError)
    end
  end

  describe '#name' do
    it 'lets you set a custom name on the builder instance' do
      builder.name('fancy name')
      expect(builder.data['name']).to eq('fancy name')
      builder.data.delete('name')
    end
  end
end