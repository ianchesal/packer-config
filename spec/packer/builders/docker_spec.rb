# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Builder::Docker do
  let(:builder) { Packer::Builder.get_builder(Packer::Builder::DOCKER) }

  describe '#initialize' do
    it 'has a type of docker' do
      expect(builder.data['type']).to eq(Packer::Builder::DOCKER)
    end
  end
end