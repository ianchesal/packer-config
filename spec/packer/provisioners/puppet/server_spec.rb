require 'spec_helper'

RSpec.describe Packer::Provisioner::Puppet::Server do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('puppet-server')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_strings) do
    %w[command1 command2]
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  let(:some_hash_of_strings) do
    {a: 'foo', b: 'bar'}
  end

  describe '#initialize' do
    it 'returns an instance' do
      expect(provisioner).to be_a_kind_of(Packer::Provisioner::Puppet::Server)
    end

    it 'has a type of puppet-server' do
      expect(provisioner.data['type']).to eq('puppet-server')
    end
  end

  describe '#client_cert_path' do
    it 'accepts a string' do
      provisioner.client_cert_path(some_string)
      expect(provisioner.data['client_cert_path']).to eq(some_string)
      provisioner.data.delete('client_cert_path')
    end

    it 'converts any argument passed to a string' do
      provisioner.client_cert_path(some_array_of_ints)
      expect(provisioner.data['client_cert_path']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('client_cert_path')
    end
  end

  describe '#client_private_key_path' do
    it 'accepts a string' do
      provisioner.client_private_key_path(some_string)
      expect(provisioner.data['client_private_key_path']).to eq(some_string)
      provisioner.data.delete('client_private_key_path')
    end

    it 'converts any argument passed to a string' do
      provisioner.client_private_key_path(some_array_of_ints)
      expect(provisioner.data['client_private_key_path']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('client_private_key_path')
    end
  end

  describe '#facter' do
    it 'accepts a has' do
      provisioner.facter(some_hash_of_strings)
      expect(provisioner.data['facter']).to eq(some_hash_of_strings)
      provisioner.data.delete('facter')
    end

    it 'raises an error if argument passed is not a Hash' do
      expect { provisioner.facter(some_string) }.to raise_error
    end
  end

  describe '#options' do
    it 'accepts a string' do
      provisioner.options(some_string)
      expect(provisioner.data['options']).to eq(some_string)
      provisioner.data.delete('options')
    end

    it 'converts any argument passed to a string' do
      provisioner.options(some_array_of_ints)
      expect(provisioner.data['options']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('options')
    end
  end

  describe '#puppet_node' do
    it 'accepts a string' do
      provisioner.puppet_node(some_string)
      expect(provisioner.data['puppet_node']).to eq(some_string)
      provisioner.data.delete('puppet_node')
    end

    it 'converts any argument passed to a string' do
      provisioner.puppet_node(some_array_of_ints)
      expect(provisioner.data['puppet_node']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('puppet_node')
    end
  end

  describe '#puppet_server' do
    it 'accepts a string' do
      provisioner.puppet_server(some_string)
      expect(provisioner.data['puppet_server']).to eq(some_string)
      provisioner.data.delete('puppet_server')
    end

    it 'converts any argument passed to a string' do
      provisioner.puppet_server(some_array_of_ints)
      expect(provisioner.data['puppet_server']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('puppet_server')
    end
  end

  describe '#prevent_sudo' do
    it 'accepts a boolean' do
      provisioner.prevent_sudo(true)
      expect(provisioner.data['prevent_sudo']).to be_truthy
      provisioner.data.delete('prevent_sudo')
    end
  end

  describe '#staging_directory' do
    it 'accepts a string' do
      provisioner.staging_directory(some_string)
      expect(provisioner.data['staging_directory']).to eq(some_string)
      provisioner.data.delete('staging_directory')
    end

    it 'converts any argument passed to a string' do
      provisioner.staging_directory(some_array_of_ints)
      expect(provisioner.data['staging_directory']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('staging_directory')
    end
  end
end