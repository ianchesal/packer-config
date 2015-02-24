# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::Null do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::NULL) }
  let(:some_string) { 'some string' }

  it 'requires a number of parameters to be valid' do
    expect{ builder.validate }.to raise_error
    builder.host :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_password :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_private_key_file :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_username :some_string
    expect(builder.validate).to be_truthy
  end

  describe '#initialize' do
    it 'has a type of null' do
      expect(builder.data['type']).to eq(Packer::Builder::NULL)
    end
  end
end
