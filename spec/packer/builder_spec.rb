# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder do
  VALID_BUILDER_TYPE = 'virtualbox-iso'

  let(:packer_builder) do
    Packer::Builder.new
  end

  describe '.get_builder' do
    it 'returns a builder' do
      expect(Packer::Builder.get_builder(VALID_BUILDER_TYPE)).to be_a_kind_of(Packer::Builder)
    end

    it 'raises an error when the builder type is not recognized' do
      expect { Packer::Builder.get_builder('unknown-type') }.to raise_error(Packer::Builder::UnrecognizedBuilderType)
    end
  end
end