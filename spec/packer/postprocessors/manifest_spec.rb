# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::Manifest do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::MANIFEST)
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  let(:hash_of_strings) do
    {
      my_custom_data: 'example',
      my_other_data: 'hidden'
    }
  end

  describe '#initialize' do
    it 'has a type of manifest' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::MANIFEST)
    end
  end

  describe '#output' do
    it 'accepts a string' do
      postprocessor.output(some_string)
      expect(postprocessor.data['output']).to eq(some_string)
      postprocessor.data.delete('output')
    end

    it 'converts any argument passed to a string' do
      postprocessor.output(some_array_of_ints)
      expect(postprocessor.data['output']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('output')
    end
  end

  describe '#strip_path' do
    it 'accepts any truthy value and converts it to true' do
      postprocessor.strip_path('this is true')
      expect(postprocessor.data['strip_path']).to be_truthy
      postprocessor.data.delete('strip_path')
    end

    it 'accepts any non-truthy value and converts it to false' do
      postprocessor.strip_path(false)
      expect(postprocessor.data['strip_path']).to be_falsey
      postprocessor.data.delete('strip_path')
    end
  end

  describe '#custom_data' do
    it 'adds a hash of strings to the key' do
      postprocessor.custom_data(hash_of_strings)
      expect(postprocessor.data['custom_data']).to eq(hash_of_strings)
      postprocessor.data.delete('custom_data')
    end
  end
end
