# Encoding: utf-8
# Copyright 2014 Ian Chesal
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
require 'spec_helper'
require 'fakefs/spec_helpers'

RSpec.describe Packer::Runner do
  describe '#run!' do
    it 'returns stdout on success' do
      open3 = class_double("Open3").as_stubbed_const(:transfer_nested_constants => true)
      expect(open3).to receive(:capture3).and_return(['output', 'error', 0])
      expect(described_class.run! 'true', quiet: true).to eq('output')
    end

    it 'raises an error on failure' do
      open3 = class_double("Open3").as_stubbed_const(:transfer_nested_constants => true)
      expect(open3).to receive(:capture3).and_return(['output', 'error', 1])
      expect{ described_class.run! 'false', quiet: true }.to raise_error
    end
  end
end
