# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::DockerTag do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::DOCKER_TAG)
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::DOCKER_TAG)
    end
  end

  describe '#repository' do
    it 'accepts a string' do
      postprocessor.repository(some_string)
      expect(postprocessor.data['repository']).to eq(some_string)
      postprocessor.data.delete('repository')
    end

    it 'converts any argument passed to a string' do
      postprocessor.repository(some_array_of_ints)
      expect(postprocessor.data['repository']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('repository')
    end
  end

  describe '#tag' do
    it 'accepts a string' do
      postprocessor.tag(some_string)
      expect(postprocessor.data['tag']).to eq(some_string)
      postprocessor.data.delete('tag')
    end

    it 'converts any argument passed to a string' do
      postprocessor.tag(some_array_of_ints)
      expect(postprocessor.data['tag']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('tag')
    end
  end
end
