# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::VMWareISO do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::VMWARE_ISO) }

  describe '#initialize' do
    it 'has a type of VMWare ISO' do
      expect(builder.data['type']).to eq(Packer::Builder::VMWARE_ISO)
    end

    it 'requires iso_checksum' do
      expect { builder.validate }.to raise_error(Packer::DataObject::DataValidationError)
      builder.iso_checksum '88197272b2a442402820fcc788a8cc7a'
      builder.iso_checksum_type "MD5"
      builder.iso_url 'path'
      builder.ssh_username 'user'
      expect { builder.validate }.not_to raise_error
    end
  end

  describe '#vmx_data' do
    it 'adds a hash of arbitrary data' do
      builder.vmx_data(
        key1: 'value1',
        key2: 'value2'
      )
      expect(builder.data['vmx_data'].keys.length).to eq(2)
    end
  end

  describe '#vmx_data_post' do
    it 'adds a hash of arbitrary data' do
      builder.vmx_data_post(
        key1: 'value1',
        key2: 'value2'
      )
      expect(builder.data['vmx_data_post'].keys.length).to eq(2)
    end
  end
end
