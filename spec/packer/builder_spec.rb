# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder do
  BUILDER_TYPE = 'virtualbox-iso'

  describe '.get_builder' do
    it 'returns a builder' do
      expect(Packer::Builder.get_builder(BUILDER_TYPE)).to be_a_kind_of(Packer::Builder)
    end

    it 'raises an error when the builder type is not recognized' do
      expect { Packer::Builder.get_builder('unknown-type') }.to raise_error(Packer::Builder::UnrecognizedBuilderType)
    end
  end
end