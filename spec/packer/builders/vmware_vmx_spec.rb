# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::VMWareVMX do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::VMWARE_VMX) }

  describe '#initialize' do
    it 'has a type of VMWare VMX' do
      expect(builder.data['type']).to eq(Packer::Builder::VMWARE_VMX)
    end

    it 'requires source_path' do
      expect { builder.validate }.to raise_error(Packer::DataObject::DataValidationError)
      builder.source_path 'path'
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
end
