# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::Amazon do
  let(:builder) { Packer::Builder::Amazon.new }
  let(:block_device_mappings) do
    [{
      "device_name" => "/dev/sdb",
      "virtual_name" => "ephemeral0"
    },
    {
      "device_name" => "/dev/sdc",
      "virtual_name" => "ephemeral1"
    }]
  end

  let(:tags) do
    {
      "a" => '1',
      "b" => '2'
    }
  end

  describe '#ami_block_device_mappings' do
    it 'adds a block device mappings data structure' do
      builder.ami_block_device_mappings(block_device_mappings)
      expect(builder.data['ami_block_device_mappings']).to eq(block_device_mappings)
      builder.data.delete('ami_block_device_mappings')
    end
  end

  describe '#launch_block_device_mappings' do
    it 'adds a block device mappings data structure' do
      builder.launch_block_device_mappings(block_device_mappings)
      expect(builder.data['launch_block_device_mappings']).to eq(block_device_mappings)
      builder.data.delete('launch_block_device_mappings')
    end
  end

  describe '#tags' do
    it 'adds a hash of strings to the key' do
      builder.tags(tags)
      expect(builder.data['tags']).to eq(tags)
      builder.data.delete('tags')
    end
  end

  describe '#run_tags' do
    it 'adds a hash of strings to the key' do
      builder.run_tags(tags)
      expect(builder.data['run_tags']).to eq(tags)
      builder.data.delete('run_tags')
    end
  end
end

RSpec.describe Packer::Builder::Amazon::EBS do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::AMAZON_EBS) }

  it 'has a type of amazon-ebs' do
    expect(builder.data['type']).to eq(Packer::Builder::AMAZON_EBS)
  end

  it 'requires ami_name, instance_type, region, source_ami, and communicator' do
    expect { builder.validate }.to raise_error(Packer::DataObject::DataValidationError)
    builder.ami_name 'foo'
    builder.instance_type 'foo'
    builder.region 'foo'
    builder.source_ami 'foo'
    builder.communicator 'ssh'
    expect { builder.validate }.not_to raise_error
  end
end

RSpec.describe Packer::Builder::Amazon::Instance do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::AMAZON_INSTANCE) }

  it 'has a type of amazon-instance' do
    expect(builder.data['type']).to eq(Packer::Builder::AMAZON_INSTANCE)
  end

  it 'requires ami_name, instance_type, region, source_ami, account_id, s3_bucket, x509_cert_path, x509_key_path, and communicator' do
    expect { builder.validate }.to raise_error(Packer::DataObject::DataValidationError)
    builder.ami_name 'foo'
    builder.instance_type 'foo'
    builder.region 'foo'
    builder.source_ami 'foo'
    builder.account_id 'foo'
    builder.s3_bucket 'foo'
    builder.x509_cert_path 'foo'
    builder.x509_key_path 'foo'
    builder.communicator 'ssh'
    expect { builder.validate }.not_to raise_error
  end
end
