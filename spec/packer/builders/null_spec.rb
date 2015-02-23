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

RSpec.describe Packer::Builder::Null do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::NULL) }
  let(:some_string) { 'some string' }

  it 'requires a number of parameters to be valid' do
    expect{ builder.validate }.to raise_error
    builder.host :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_password :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_private_key_file :some_string
    expect{ builder.validate }.to raise_error
    builder.ssh_username :some_string
    expect(builder.validate).to be_truthy
  end

  describe '#initialize' do
    it 'has a type of null' do
      expect(builder.data['type']).to eq(Packer::Builder::NULL)
    end
  end
end
