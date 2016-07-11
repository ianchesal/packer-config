# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::ShellLocal do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::SHELL_LOCAL)
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_strings) do
    %w[command1 command2]
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::SHELL_LOCAL)
    end
  end

describe '#inline' do
    it 'accepts an array of commands' do
      postprocessor.inline(some_array_of_strings)
      expect(postprocessor.data['inline']).to eq(some_array_of_strings)
      postprocessor.data.delete('inline')
    end

    it 'raise an error if it is empty' do
      expect { postprocessor.inline('') }.to raise_error
      postprocessor.data.delete('inline')
    end

    it 'converts all commands to strings' do
      postprocessor.inline(some_array_of_ints)
      expect(postprocessor.data['inline']).to eq(some_array_of_ints.map(&:to_s))
      postprocessor.data.delete('inline')
    end

    it 'raises an error if the commands argument cannot be made an Array' do
      expect { postprocessor.inline(some_string) }.to raise_error
    end

    it 'raises an error if #script or #scripts method was already called' do
      postprocessor.data['script'] = 1
      expect { postprocessor.inline(some_array_of_strings) }.to raise_error
      postprocessor.data.delete('script')
      postprocessor.data['scripts'] = 1
      expect { postprocessor.inline(some_array_of_strings) }.to raise_error
      postprocessor.data.delete('scripts')
    end
  end

  describe '#script' do
    it 'accepts a string' do
      postprocessor.script(some_string)
      expect(postprocessor.data['script']).to eq(some_string)
      postprocessor.data.delete('script')
    end

    it 'converts any argument passed to a string' do
      postprocessor.script(some_array_of_ints)
      expect(postprocessor.data['script']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('script')
    end

    it 'raises an error if #inline or #scripts method was already called' do
      postprocessor.data['inline'] = 1
      expect { postprocessor.script(some_string) }.to raise_error
      postprocessor.data.delete('inline')
      postprocessor.data['scripts'] = 1
      expect { postprocessor.script(some_string) }.to raise_error
      postprocessor.data.delete('scripts')
    end
  end

  describe '#scripts' do
    it 'accepts an array of commands' do
      postprocessor.scripts(some_array_of_strings)
      expect(postprocessor.data['scripts']).to eq(some_array_of_strings)
      postprocessor.data.delete('scripts')
    end

    it 'converts all commands to strings' do
      postprocessor.scripts(some_array_of_ints)
      expect(postprocessor.data['scripts']).to eq(some_array_of_ints.map(&:to_s))
      postprocessor.data.delete('scripts')
    end

    it 'raises an error if the commands argument cannot be made an Array' do
      expect { postprocessor.scripts(some_string) }.to raise_error
    end

    it 'raises an error if #inline or #script method was already called' do
      postprocessor.data['script'] = 1
      expect { postprocessor.scripts(some_array_of_strings) }.to raise_error
      postprocessor.data.delete('scripts')
      postprocessor.data['inline'] = 1
      expect { postprocessor.scripts(some_array_of_strings) }.to raise_error
      postprocessor.data.delete('scripts')
    end
  end
end
