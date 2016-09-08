# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Provisioner::Salt do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('salt-masterless')
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

  it 'requires a local_state_tree setting' do
    expect { provisioner.validate }.to raise_error
  end

  describe '#initialize' do
    it 'has a type of salt-masterless' do
      expect(provisioner.data['type']).to eq('salt-masterless')
    end
  end

  describe '#bootstrap_args' do
    it 'accepts a string' do
      provisioner.bootstrap_args some_string
      expect(provisioner.data['bootstrap_args']).to eq(some_string)
      provisioner.data.delete('bootstrap_args')
    end

    it 'converts any argument passed to a string' do
      provisioner.bootstrap_args some_array_of_ints
      expect(provisioner.data['bootstrap_args']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('bootstrap_args')
    end
  end

  describe '#local_pillar_roots' do
    it 'accepts a string' do
      provisioner.local_pillar_roots some_string
      expect(provisioner.data['local_pillar_roots']).to eq(some_string)
      provisioner.data.delete('local_pillar_roots')
    end

    it 'converts any argument passed to a string' do
      provisioner.local_pillar_roots some_array_of_ints
      expect(provisioner.data['local_pillar_roots']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('local_pillar_roots')
    end
  end

  describe '#local_state_tree' do
    it 'accepts a string' do
      provisioner.local_state_tree some_string
      expect(provisioner.data['local_state_tree']).to eq(some_string)
      provisioner.data.delete('local_state_tree')
    end

    it 'converts any argument passed to a string' do
      provisioner.local_state_tree some_array_of_ints
      expect(provisioner.data['local_state_tree']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('local_state_tree')
    end
  end

  describe '#minion_config' do
    it 'accepts a string' do
      provisioner.minion_config some_string
      expect(provisioner.data['minion_config']).to eq(some_string)
      provisioner.data.delete('minion_config')
    end

    it 'converts any argument passed to a string' do
      provisioner.minion_config some_array_of_ints
      expect(provisioner.data['minion_config']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('minion_config')
    end
  end

  describe '#temp_config_dir' do
    it 'accepts a string' do
      provisioner.temp_config_dir some_string
      expect(provisioner.data['temp_config_dir']).to eq(some_string)
      provisioner.data.delete('temp_config_dir')
    end

    it 'converts any argument passed to a string' do
      provisioner.temp_config_dir some_array_of_ints
      expect(provisioner.data['temp_config_dir']).to eq(some_array_of_ints.to_s)
      provisioner.data.delete('temp_config_dir')
    end
  end

  describe '#skip_bootstrap' do
    it 'accepts a boolean' do
      provisioner.skip_bootstrap(true)
      expect(provisioner.data['skip_bootstrap']).to be_truthy
      provisioner.skip_bootstrap(false)
      expect(provisioner.data['skip_bootstrap']).to be_falsey
      provisioner.data.delete('skip_bootstrap')
    end
  end
end
