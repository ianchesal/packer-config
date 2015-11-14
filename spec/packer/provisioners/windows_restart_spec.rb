# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Provisioner::WindowsRestart do
  let(:provisioner) do
    Packer::Provisioner.get_provisioner('windows-restart')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of windows-restart' do
      expect(provisioner.data['type']).to eq('windows-restart')
    end
  end

  shared_examples 'test string parameter' do |key|
    it 'accepts a string' do
      provisioner.send(key.to_sym, some_string)
      expect(provisioner.data[key]).to eq(some_string)
      provisioner.data.delete(key)
    end

    it 'converts any argument passed to a string' do
      provisioner.send(key.to_sym, some_array_of_ints)
      expect(provisioner.data[key]).to eq(some_array_of_ints.to_s)
      provisioner.data.delete(key)
    end
  end

  describe '#restart_command' do
    include_examples 'test string parameter', 'restart_command'
  end

  describe '#restart_check_command' do
    include_examples 'test string parameter', 'restart_check_command'
  end

  describe '#restart_timeout' do
    include_examples 'test string parameter', 'restart_timeout'
  end
end
