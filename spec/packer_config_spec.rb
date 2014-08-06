# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Config do
  BUILDER_TYPE = 'virtualbox-iso'

  describe '#new' do
    it 'returns an instance' do
      expect(Packer::Config.new).to be_a_kind_of(Packer::Config)
    end
  end
end