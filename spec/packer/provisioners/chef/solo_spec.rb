# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Provisioner::Chef::Solo do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('chef-solo')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_strings) do
    %w[commmand1 command2]
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  let(:some_hash_of_strings) do
    {a: 'foo', b: 'bar'}
  end

  describe '#initialize' do
    it 'has a type of chef-solo' do
      expect(provisioner.data['type']).to eq('chef-solo')
    end
  end

  describe '#config_template`' do
    it 'accepts a string' do
      provisioner.config_template(some_string)
      expect(provisioner.data['config_template']).to eq(some_string)
      provisioner.data.delete('config_template')
    end

    it 'converts any argument passed to a string' do
      provisioner.config_template(some_array_of_ints)
      expect(provisioner.data['config_template']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('config_template')
    end
  end

  describe '#cookbook_paths' do
    it 'accepts an array of strings' do
      provisioner.cookbook_paths(some_array_of_strings)
      expect(provisioner.data['cookbook_paths']).to eq(some_array_of_strings)
      provisioner.data.delete('cookbook_paths')
    end

    it 'converts all entities to strings' do
      provisioner.cookbook_paths(some_array_of_ints)
      expect(provisioner.data['cookbook_paths']).to eq(some_array_of_ints.map(&:to_s))
      provisioner.data.delete('cookbook_paths')
    end

    it 'raises an error if the argument cannot be made an Array' do
      expect { provisioner.cookbook_paths(some_string) }.to raise_error
    end
  end

  describe '#remote_cookbook_paths' do
    it 'accepts an array of strings' do
      provisioner.remote_cookbook_paths(some_array_of_strings)
      expect(provisioner.data['remote_cookbook_paths']).to eq(some_array_of_strings)
      provisioner.data.delete('remote_cookbook_paths')
    end

    it 'converts all entities to strings' do
      provisioner.remote_cookbook_paths(some_array_of_ints)
      expect(provisioner.data['remote_cookbook_paths']).to eq(some_array_of_ints.map(&:to_s))
      provisioner.data.delete('remote_cookbook_paths')
    end

    it 'raises an error if the argument cannot be made an Array' do
      expect { provisioner.remote_cookbook_paths(some_string) }.to raise_error
    end
  end

  describe '#run_list' do
    it 'accepts an array of strings' do
      provisioner.run_list(some_array_of_strings)
      expect(provisioner.data['run_list']).to eq(some_array_of_strings)
      provisioner.data.delete('run_list')
    end

    it 'converts all entities to strings' do
      provisioner.run_list(some_array_of_ints)
      expect(provisioner.data['run_list']).to eq(some_array_of_ints.map(&:to_s))
      provisioner.data.delete('run_list')
    end

    it 'raises an error if the argument cannot be made an Array' do
      expect { provisioner.run_list(some_string) }.to raise_error
    end
  end
end
