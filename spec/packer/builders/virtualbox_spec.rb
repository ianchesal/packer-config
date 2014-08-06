# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::VirtualBoxISO do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::VIRTUALBOX_ISO) }
  let(:in_commands_strings)  { [["command1", "1"], ["command2", "2"]] }
  let(:in_commands_mixed)    { [["command1",  1 ], ["command2",  2 ]] }
  let(:out_commands_strings) { [["command1", "1"], ["command2", "2"]] }

  describe '#initialize' do
    it 'has a type of virtualbox-iso' do
      expect(builder.data['type']).to eq(Packer::Builder::VIRTUALBOX_ISO)
    end
  end

  describe '#vboxmanage' do
    it 'builds an array of arrays of strings' do
      builder.vboxmanage(in_commands_mixed)
      expect( builder.data['vboxmanage'] ).to eq(out_commands_strings)
      builder.data.delete('vboxmanage')
    end
  end

  describe '#vboxmanage_post' do
    it 'builds an array of arrays of strings' do
      builder.vboxmanage_post(in_commands_mixed)
      expect( builder.data['vboxmanage_post'] ).to eq(out_commands_strings)
      builder.data.delete('vboxmanage_post')
    end
  end
end