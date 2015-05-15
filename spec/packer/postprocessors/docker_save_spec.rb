# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::DockerSave do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::DOCKER_SAVE)
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::DOCKER_SAVE)
    end
  end

  describe '#path' do
    it 'accepts a string' do
      postprocessor.path(some_string)
      expect(postprocessor.data['path']).to eq(some_string)
      postprocessor.data.delete('path')
    end

    it 'converts any argument passed to a string' do
      postprocessor.path(some_array_of_ints)
      expect(postprocessor.data['path']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('path')
    end
  end
end
