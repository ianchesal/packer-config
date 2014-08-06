# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Provisioner::Shell do
  let(:shell_provisioner) do
    Packer::Provisioner.get_provisioner('shell')
  end

  let(:some_string) do
    'some string'
  end

  let(:some_array_of_strings) do
    %w[commmand1 command2]
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(shell_provisioner.data['type']).to eq('shell')
    end
  end

  describe '#inline' do
    it 'accepts an array of commands' do
      shell_provisioner.inline(some_array_of_strings)
      expect(shell_provisioner.data['inline']).to eq(some_array_of_strings)
      shell_provisioner.data.delete('inline')
    end

    it 'converts all commands to strings' do
      shell_provisioner.inline(some_array_of_ints)
      expect(shell_provisioner.data['inline']).to eq(some_array_of_ints.map{ |c| c.to_s })
      shell_provisioner.data.delete('inline')
    end

    it 'raises an error if the commands argument cannot be made an Array' do
      expect { shell_provisioner.inline(some_string) }.to raise_error(TypeError)
    end

    it 'raises an error if #script or #scripts method was already called' do
      shell_provisioner.data['script'] = 1
      expect { shell_provisioner.inline(some_array_of_strings) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('script')
      shell_provisioner.data['scripts'] = 1
      expect { shell_provisioner.inline(some_array_of_strings) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('scripts')
    end
  end

  describe '#script' do
    it 'accepts a string' do
      shell_provisioner.script(some_string)
      expect(shell_provisioner.data['script']).to eq(some_string)
      shell_provisioner.data.delete('script')
    end

    it 'converts any argument passed to a string' do
      shell_provisioner.script(some_array_of_ints)
      expect(shell_provisioner.data['script']).to eq(some_array_of_ints.to_s)
      shell_provisioner.data.delete('script')
    end

    it 'raises an error if #inline or #scripts method was already called' do
      shell_provisioner.data['inline'] = 1
      expect { shell_provisioner.script(some_string) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('inline')
      shell_provisioner.data['scripts'] = 1
      expect { shell_provisioner.script(some_string) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('scripts')
    end
  end

  describe '#inline' do
    it 'accepts an array of commands' do
      shell_provisioner.inline(some_array_of_strings)
      expect(shell_provisioner.data['inline']).to eq(some_array_of_strings)
      shell_provisioner.data.delete('inline')
    end

    it 'converts all commands to strings' do
      shell_provisioner.inline(some_array_of_ints)
      expect(shell_provisioner.data['inline']).to eq(some_array_of_ints.map{ |c| c.to_s })
      shell_provisioner.data.delete('inline')
    end

    it 'raises an error if the commands argument cannot be made an Array' do
      expect { shell_provisioner.inline(some_string) }.to raise_error(TypeError)
    end

    it 'raises an error if #script or #scripts method was already called' do
      shell_provisioner.data['script'] = 1
      expect { shell_provisioner.inline(some_array_of_strings) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('script')
      shell_provisioner.data['scripts'] = 1
      expect { shell_provisioner.inline(some_array_of_strings) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      shell_provisioner.data.delete('scripts')
    end
  end

  describe "binary" do
    it 'is true if you pass a non-false value' do
      shell_provisioner.binary(true)
      expect(shell_provisioner.data['binary']).to be_truthy
      shell_provisioner.data.delete('binary')
      shell_provisioner.binary(some_string)
      expect(shell_provisioner.data['binary']).to be_truthy
      shell_provisioner.data.delete('binary')
    end

    it 'is false if you pass a false value' do
      shell_provisioner.binary(false)
      expect(shell_provisioner.data['binary']).to be_falsey
      shell_provisioner.data.delete('binary')
    end
  end

  describe "environment_vars" do
    it 'accepts an array of strings' do
      shell_provisioner.environment_vars(%w[A=a B=b C=c])
      expect(shell_provisioner.data['environment_vars']).to eq(%w[A=a B=b C=c])
      shell_provisioner.data.delete('environment_vars')
    end
  end

  describe "execute_command" do
    it 'accepts a string' do
      shell_provisioner.execute_command(some_string)
      expect(shell_provisioner.data['execute_command']).to eq(some_string)
      shell_provisioner.data.delete('execute_command')
    end
  end

  describe "inline_shebang" do
    it 'accepts a string' do
      shell_provisioner.inline_shebang(some_string)
      expect(shell_provisioner.data['inline_shebang']).to eq(some_string)
      shell_provisioner.data.delete('inline_shebang')
    end
  end

  describe "remote_path" do
    it 'accepts a string' do
      shell_provisioner.remote_path(some_string)
      expect(shell_provisioner.data['remote_path']).to eq(some_string)
      shell_provisioner.data.delete('remote_path')
    end
  end
end