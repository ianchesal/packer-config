# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::Vagrant do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::VAGRANT)
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::VAGRANT)
    end
  end
end