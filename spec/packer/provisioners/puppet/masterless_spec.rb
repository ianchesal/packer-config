require 'spec_helper'

RSpec.describe Packer::Provisioner do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('puppet-masterless')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_hash_of_strings) do
    { :foo => 'bar', :bar => 'foo' }
  end

  let(:some_array_of_strings) do
    %w[command1 command2]
  end

  let(:some_boolean) do
    true
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'returns an instance' do
      expect(provisioner).to be_a_kind_of(Packer::Provisioner::Puppet::Masterless)
    end

    it 'has a type of masterless' do
      expect(provisioner.data['type']).to eq('puppet-masterless')
    end
  end

  describe '#manifest_file' do
    it 'accepts a string' do
      provisioner.manifest_file(some_string)
      expect(provisioner.data['manifest_file']).to eq(some_string)
      provisioner.data.delete('manifest_file')
    end

    it 'converts any argument passed to a string' do
      provisioner.manifest_file(some_array_of_ints)
      expect(provisioner.data['manifest_file']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('manifest_file')
    end
  end

  describe '#execute_command' do
    it 'accepts a string' do
      provisioner.execute_command(some_string)
      expect(provisioner.data['execute_command']).to eq(some_string)
      provisioner.data.delete('execute_command')
    end

    it 'converts any argument passed to a string' do
      provisioner.execute_command(some_array_of_ints)
      expect(provisioner.data['execute_command']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('execute_command')
    end
  end

  describe '#facter' do
    it 'accepts a hash' do
      provisioner.facter(some_hash_of_strings)
      expect(provisioner.data['facter']).to eq(some_hash_of_strings)
      provisioner.data.delete('facter')
    end

    it 'raises an error if arguments cannot be made into a hash' do
      expect{ provisioner.facter(some_string) }.to raise_error
    end
  end

  describe '#hiera_config_path' do
    it 'accepts a string' do
      provisioner.hiera_config_path(some_string)
      expect(provisioner.data['hiera_config_path']).to eq(some_string)
      provisioner.data.delete('hiera_config_path')
    end

    it 'converts any argument passed to a string' do
      provisioner.hiera_config_path(some_array_of_ints)
      expect(provisioner.data['hiera_config_path']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('hiera_config_path')
    end
  end

  describe '#manifest_dir' do
    it 'accepts a string' do
      provisioner.manifest_dir(some_string)
      expect(provisioner.data['manifest_dir']).to eq(some_string)
      provisioner.data.delete('manifest_dir')
    end

    it 'converts any argument passed to a string' do
      provisioner.manifest_dir(some_array_of_ints)
      expect(provisioner.data['manifest_dir']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('manifest_dir')
    end
  end

  describe '#module_paths' do
    it 'accepts an array of strings'do
      provisioner.module_paths(some_array_of_strings)
      expect(provisioner.data['module_paths']).to eq(some_array_of_strings)
      provisioner.data.delete('module_paths')
    end

    it 'converts any argument passed to an array string' do
      provisioner.module_paths(some_array_of_ints)
      expect(provisioner.data['module_paths']).to eq(some_array_of_ints.map(&:to_s))
      provisioner.data.delete('module_paths')
    end
  end

  describe '#prevent_sudo' do
    it 'accepts a boolean' do
      provisioner.prevent_sudo(some_boolean)
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