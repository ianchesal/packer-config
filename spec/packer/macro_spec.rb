# Encoding: utf-8
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
