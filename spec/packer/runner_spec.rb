# Encoding: utf-8
require 'spec_helper'
require 'fakefs/spec_helpers'

RSpec.describe Packer::Runner do
  describe '#run!' do
    it 'returns stdout on success' do
      open3 = class_double("Open3").as_stubbed_const(:transfer_nested_constants => true)
      expect(open3).to receive(:capture3).and_return(['output', 'error', 0])
      expect(described_class.run!('true', quiet: true)).to eq('output')
    end

    it 'raises an error on failure' do
      open3 = class_double("Open3").as_stubbed_const(:transfer_nested_constants => true)
      expect(open3).to receive(:capture3).and_return(['output', 'error', 1])
      expect { described_class.run!('false', quiet: true) }.to raise_error
    end
  end
end
