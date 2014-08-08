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

RSpec.describe Packer::EnvVar do
  let(:envvar) do
    Packer::EnvVar.new
  end

  it 'returns a packer.io envvar string for any method' do
    expect(envvar.FOO).to eq("{{env `FOO`}}")
    expect(envvar.BAR).to eq("{{env `BAR`}}")
    expect(envvar.MOO).to eq("{{env `MOO`}}")
  end

  it 'never changes the capitalization of the env var' do
    expect(envvar.foo).to eq("{{env `foo`}}")
    expect(envvar.Foo).to eq("{{env `Foo`}}")
    expect(envvar.fOo).to eq("{{env `fOo`}}")
  end

  it 'responds to anything' do
    expect(envvar.respond_to? 'anything').to       be_truthy
    expect(envvar.respond_to? 'anything_else').to  be_truthy
  end
end