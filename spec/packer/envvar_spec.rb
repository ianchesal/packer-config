# Encoding: utf-8
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
