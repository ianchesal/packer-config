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

RSpec.describe Packer::Macro do
  let(:macro) do
    Packer::Macro.new
  end

  it 'returns a packer.io macro string for any method' do
    expect(macro.Foo).to eq("{{ .Foo }}")
    expect(macro.Bar).to eq("{{ .Bar }}")
    expect(macro.Moo).to eq("{{ .Moo }}")
  end

  it 'always capitalizes the first letter in the macro' do
    expect(macro.foo).to eq("{{ .Foo }}")
    expect(macro.Foo).to eq("{{ .Foo }}")
    expect(macro.fOo).to eq("{{ .FOo }}")
  end

  it 'responds to anything' do
    expect(macro.respond_to? 'anything').to       be_truthy
    expect(macro.respond_to? 'anything_else').to  be_truthy
  end
end