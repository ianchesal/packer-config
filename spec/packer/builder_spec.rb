# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder do
  VALID_BUILDER_TYPE = Packer::Builder::VIRTUALBOX_ISO

  let(:builder) { Packer::Builder.new }

  describe '.get_builder' do
    it 'returns a builder' do
      expect(Packer::Builder.get_builder(VALID_BUILDER_TYPE)).to be_a_kind_of(Packer::Builder)
    end

    it 'raises an error when the builder type is not recognized' do
      expect { Packer::Builder.get_builder('unknown-type') }.to raise_error
    end
  end

  describe '#name' do
    it 'lets you set a custom name on the builder instance' do
      builder.name('fancy name')
      expect(builder.data['name']).to eq('fancy name')
      builder.data.delete('name')
    end
  end

  describe '#communicator' do
    it 'raises an error if you try to set an invalid communicator' do
      expect { builder.communicator 'foo' }.to raise_error Packer::DataObject::DataValidationError
    end
  end
end
