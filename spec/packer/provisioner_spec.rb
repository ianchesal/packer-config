# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Provisioner do
  PROVISIONER_TYPE = 'shell'

  let(:provisioner) do
    Packer::Provisioner.new
  end

  let(:overrides) do
    {
      "key1" => "value1",
      "key2" => "value2"
    }
  end

  describe '.get_provisioner' do
    it 'returns a provisioner' do
      expect(Packer::Provisioner.get_provisioner(PROVISIONER_TYPE)).to be_a_kind_of(Packer::Provisioner)
    end

    it 'raises an error when the provisioner type is not recognized' do
      expect { Packer::Provisioner.get_provisioner('unknown-type') }.to raise_error
    end
  end

  describe '#only' do
    it 'adds an only exception' do
      provisioner.only('thing1')
      expect(provisioner.data['only']).to eq(%w[thing1])
      provisioner.only('thing2')
      expect(provisioner.data['only']).to eq(%w[thing1 thing2])
    end
  end

  describe '#except' do
    it 'adds an execpt exception' do
      provisioner.except('thing3')
      expect(provisioner.data['except']).to eq(%w[thing3])
      provisioner.except('thing4')
      expect(provisioner.data['except']).to eq(%w[thing3 thing4])
    end
  end

  describe '#pause_before' do
    it 'adds a pause time' do
      provisioner.pause_before(10)
      expect(provisioner.data['pause_before']).to eq("10")
      provisioner.pause_before("10s")
      expect(provisioner.data['pause_before']).to eq("10s")
    end
  end

  describe '#override' do
    it 'adds a hash overridef override values to a list of overrides' do
      provisioner.override('build', overrides)
      expect(provisioner.data['override']['build']).to eq(overrides)
    end

    it 'raises a TypeError when the overrides are not a hash' do
      expect { provisioner.override('build', 10) }.to raise_error
    end
  end
end
