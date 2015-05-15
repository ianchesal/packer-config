# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::PostProcessor::DockerPush do
  let(:postprocessor) do
    Packer::PostProcessor.get_postprocessor(Packer::PostProcessor::DOCKER_PUSH)
  end

  let(:some_string) do
    'some string'
  end

  let(:some_boolean) do
    true
  end

  let(:some_array_of_ints) do
    [1, 2, 3]
  end

  describe '#initialize' do
    it 'has a type of shell' do
      expect(postprocessor.data['type']).to eq(Packer::PostProcessor::DOCKER_PUSH)
    end
  end

  describe '#login' do
    it 'accepts a boolean' do
      postprocessor.login(some_boolean)
      expect(postprocessor.data['login']).to be_truthy
      postprocessor.data.delete('login')
    end
  end

  describe '#login_email' do
    it 'accepts a string' do
      postprocessor.login_email(some_string)
      expect(postprocessor.data['login_email']).to eq(some_string)
      postprocessor.data.delete('login_email')
    end

    it 'converts any argument passed to a string' do
      postprocessor.login_email(some_array_of_ints)
      expect(postprocessor.data['login_email']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('login_email')
    end
  end

  describe '#login_username' do
    it 'accepts a string' do
      postprocessor.login_username(some_string)
      expect(postprocessor.data['login_username']).to eq(some_string)
      postprocessor.data.delete('login_username')
    end

    it 'converts any argument passed to a string' do
      postprocessor.login_username(some_array_of_ints)
      expect(postprocessor.data['login_username']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('login_username')
    end
  end

  describe '#login_password' do
    it 'accepts a string' do
      postprocessor.login_password(some_string)
      expect(postprocessor.data['login_password']).to eq(some_string)
      postprocessor.data.delete('login_password')
    end

    it 'converts any argument passed to a string' do
      postprocessor.login_password(some_array_of_ints)
      expect(postprocessor.data['login_password']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('login_password')
    end
  end

  describe '#login_server' do
    it 'accepts a string' do
      postprocessor.login_server(some_string)
      expect(postprocessor.data['login_server']).to eq(some_string)
      postprocessor.data.delete('login_server')
    end

    it 'converts any argument passed to a string' do
      postprocessor.login_server(some_array_of_ints)
      expect(postprocessor.data['login_server']).to eq(some_array_of_ints.to_s)
      postprocessor.data.delete('login_server')
    end
  end
end
