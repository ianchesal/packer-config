# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::DataObject do
  let(:dataobject) { Packer::DataObject.new }
  let(:some_string) { 'some string' }
  let(:keys) { %w[key1 key2] }
  let(:some_array_of_strings) { %w[value1 value2 value3] }
  let(:some_array_of_ints) { [1, 2, 3] }
  let(:in_commands_strings)  { [["command1", "1"], ["command2", "2"]] }
  let(:in_commands_mixed)    { [["command1",  1 ], ["command2",  2 ]] }
  let(:out_commands_strings) { [["command1", "1"], ["command2", "2"]] }

  describe "#initialize" do
    it 'has a data hash' do
      expect(dataobject.data).to eq({})
    end
  end

  describe '#add_required' do
    it 'tracks required settings' do
      dataobject.add_required('a', 'b', ['c', 'd'])
      expect(dataobject.required).to eq(['a', 'b', ['c', 'd']])
    end
  end

  describe '#validate' do
    it 'returns true when all required settings are present' do
      dataobject.add_required('key')
      dataobject.__add_string('key', 'value')
      expect(dataobject.validate).to be_truthy
      dataobject.data = []
      dataobject.required = []
    end

    it 'raises an error when a required setting is missing' do
      dataobject.add_required('key')
      expect { dataobject.validate }.to raise_error(Packer::DataObject::DataValidationError)
      dataobject.data = []
      dataobject.required = []
    end

    it 'returns true when exactly one setting from an exclusive set is preset' do
      dataobject.add_required(['key1', 'key2'])
      dataobject.__add_string('key1', 'value')
      expect(dataobject.validate).to be_truthy
      dataobject.data = []
      dataobject.required = []
    end

    it 'raises an error when no settings from an exclusive set are present' do
      dataobject.add_required(['key1', 'key2'])
      expect { dataobject.validate }.to raise_error(Packer::DataObject::DataValidationError)
      dataobject.data = []
      dataobject.required = []
    end

    it 'raises an error when more than one setting from an exclusive set is present' do
      dataobject.add_required(['key1', 'key2'])
      dataobject.__add_string('key1', 'value')
      dataobject.__add_string('key2', 'value')
      expect { dataobject.validate }.to raise_error(Packer::DataObject::DataValidationError)
      dataobject.data = []
      dataobject.required = []
    end

    it 'returns true when there are no required settings to validate' do
      expect(dataobject.validate).to be_truthy
    end
  end

  describe "#__exclusive_key_error" do
    it 'returns true when the key is exclusive' do
      dataobject.data[keys[0]] = 'value'
      expect(dataobject.__exclusive_key_error(keys[0], keys[1..-1])).to be_truthy
      dataobject.data.delete(keys[0])
    end

    it 'raises an error when the key is not exclusive' do
      dataobject.data[keys[0]] = 'value'
      dataobject.data[keys[1]] = 'value'
      expect { dataobject.__exclusive_key_error(keys[0], keys[1..-1]) }.to raise_error(Packer::DataObject::ExclusiveKeyError)
      dataobject.data.delete(keys)
    end
  end

  describe '#__add_array_of_strings' do
    it 'assigns an array of strings to key' do
      dataobject.__add_array_of_strings('key', some_array_of_strings)
      expect(dataobject.data['key']).to eq(some_array_of_strings)
      dataobject.data.delete('key')
    end

    it 'converts an array of non-strings to strings and assigns them to key' do
      dataobject.__add_array_of_strings('key', some_array_of_ints)
      expect(dataobject.data['key']).to eq(some_array_of_ints.map{ |c| c.to_s })
      dataobject.data.delete('key')
    end

    it 'raises an error if the values cannot be turned in to an Array' do
      expect { dataobject.__add_array_of_strings('key', 'some string') }.to raise_error(TypeError)
    end
  end

  describe "#__add_array_of_array_of_strings" do
    it 'assigns an array of array of strings to key' do
      dataobject.__add_array_of_array_of_strings('key', in_commands_strings)
      expect(dataobject.data['key']).to eq(out_commands_strings)
      dataobject.data.delete('key')
    end

    it 'converts non-strings to strings in the sub-arrays during assignment to key' do
      dataobject.__add_array_of_array_of_strings('key', in_commands_mixed)
      expect(dataobject.data['key']).to eq(out_commands_strings)
      dataobject.data.delete('key')
    end

    it 'raises an error if the values argument is not an array' do
      expect { dataobject.__add_array_of_array_of_strings('key', 'some string') }.to raise_error(TypeError)
    end

    it 'raises an error if any element in the values argument is not an array' do
      expect { dataobject.__add_array_of_array_of_strings('key', [['legal'], 'illegal']) }.to raise_error(TypeError)
    end
  end

  describe '#__add_string' do
    it 'accepts a string' do
      dataobject.__add_string('key', some_string)
      expect(dataobject.data['key']).to eq(some_string)
      dataobject.data.delete('key')
    end

    it 'converts any argument passed to a string' do
      dataobject.__add_string('key', some_array_of_ints)
      expect(dataobject.data['key']).to eq(some_array_of_ints.to_s)
      dataobject.data.delete('key')
    end
  end

  describe '#__add_integer' do
    it 'accepts anything that can be converted to an integer with #to_i' do
      dataobject.__add_integer(keys[0], 1)
      dataobject.__add_integer(keys[1], "2")
      expect(dataobject.data[keys[0]]).to eq(1)
      expect(dataobject.data[keys[1]]).to eq(2)
      dataobject.data.delete(keys)
    end

    it 'raises an error if the value cannot be converted to an integer with #to_i' do
      expect { dataobject.__add_integer('key', StandardError.new("not convertable")) }.to raise_error(NoMethodError)
    end
  end

  describe '#__add_boolean' do
    it 'accepts any truthy value and converts it to true' do
      dataobject.__add_boolean('key', some_string)
      expect(dataobject.data['key']).to be_truthy
      dataobject.data.delete('key')
    end

    it 'accepts any non-truthy value and converts it to false' do
      dataobject.__add_boolean('key', false)
      expect(dataobject.data['key']).to be_falsey
      dataobject.data.delete('key')
    end
  end

end