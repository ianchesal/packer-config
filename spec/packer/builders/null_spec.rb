# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::Null do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::NULL) }
  let(:some_string) { 'some string' }

  it 'has a type of null' do
    expect(builder.data['type']).to eq(Packer::Builder::NULL)
  end
end
