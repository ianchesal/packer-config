# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::Qemu do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::QEMU) }
  let(:in_commands_strings)  { [["command1", "1"], ["command2", "2"]] }
  let(:in_commands_mixed)    { [["command1",  1 ], ["command2",  2 ]] }
  let(:out_commands_strings) { [["command1", "1"], ["command2", "2"]] }

  it 'has a type of virtualbox-iso' do
    expect(builder.data['type']).to eq(Packer::Builder::QEMU)
  end

  it 'requires iso_checksum, iso_checksum_type, iso_url, communicator and ssh_username' do
    expect { builder.validate }.to raise_error(Packer::DataObject::DataValidationError)
    builder.iso_checksum '88197272b2a442402820fcc788a8cc7a'
    builder.iso_checksum_type "MD5"
    builder.iso_url 'path'
    builder.communicator 'ssh'
    builder.ssh_username 'root'
    expect { builder.validate }.not_to raise_error
  end

  describe '#qemuargs' do
    it 'builds an array of arrays of strings' do
      builder.qemuargs(in_commands_mixed)
      expect( builder.data['qemuargs'] ).to eq(out_commands_strings)
      builder.data.delete('qemuargs')
    end
  end
end
