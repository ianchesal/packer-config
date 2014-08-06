# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::DockerPush do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::DOCKER_PUSH)
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::DOCKER_PUSH)
    end
  end
end