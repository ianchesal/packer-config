# Encoding: utf-8
# Copyright 2014 Ian Chesal
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
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