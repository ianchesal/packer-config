# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::DataObject do
  let(:dataobject)            { Packer::DataObject.new }
  let(:some_string)           { 'some string' }
  let(:keys)                  { %w[key1 key2] }
  let(:some_array_of_strings) { %w[value1 value2 value3] }
  let(:some_array_of_ints)    { [1, 2, 3] }
  let(:some_hash_of_mixed)    { { 'a' =>  1,  'b' =>  2  } }
  let(:some_hash_of_strings)  { { 'a' => '1', 'b' => '2' } }
  let(:in_commands_strings)   { [["command1", "1"], ["command2", "2"]] }
  let(:in_commands_mixed)     { [["command1",  1 ], ["command2",  2 ]] }
  let(:out_commands_strings)  { [["command1", "1"], ["command2", "2"]] }

  describe "#initialize" do
    it 'has a data hash' do
      expect(dataobject.data).to eq({})
    end
  end

  describe '#add_required' do
    it 'tracks required settings' do
      dataobject.add_required('a', 'b')
      dataobject.add_required(['c', 'd'])
      expect(dataobject.required).to eq(['a', 'b', ['c', 'd']])
    end
  end

  describe '#add_key_dependency' do
    it 'tracks dependencies on a key' do
      dataobject.add_key_dependencies({
        'key' => ['a', 'b'],
        'a' => ['b', 'c']
      })

      expect(dataobject.key_dependencies).to eq({
        'key' => ['a', 'b'],
        'a' => ['b', 'c']
      })
    end
  end

  describe '#validate' do
    describe '#validate_required' do
      it 'returns true when all required settings are present' do
        dataobject.add_required('key')
        dataobject.__add_string('key', 'value')
        expect(dataobject.validate_required).to be_truthy
        dataobject.data = []
        dataobject.required = []
      end

      it 'raises an error when a required setting is missing' do
        dataobject.add_required('key')
        expect { dataobject.validate_required }.to raise_error
        dataobject.data = []
        dataobject.required = []
      end

      it 'returns true when exactly one setting from an exclusive set is preset' do
        dataobject.add_required(['key1', 'key2'])
        dataobject.__add_string('key1', 'value')
        expect(dataobject.validate_required).to be_truthy
        dataobject.data = []
        dataobject.required = []
      end

      it 'raises an error when no settings from an exclusive set are present' do
        dataobject.add_required(['key1', 'key2'])
        expect { dataobject.validate_required }.to raise_error
        dataobject.data = []
        dataobject.required = []
      end

      it 'raises an error when more than one setting from an exclusive set is present' do
        dataobject.add_required(['key1', 'key2'])
        dataobject.__add_string('key1', 'value')
        dataobject.__add_string('key2', 'value')
        expect { dataobject.validate_required }.to raise_error
        dataobject.data = []
        dataobject.required = []
      end

      it 'returns true when there are no required settings to validate_required' do
        expect(dataobject.validate_required).to be_truthy
      end
    end

    describe '#validate_key_dependencies' do
      # it 'raises an error when a key is missing a dependency' do
      #  dataobject.add_required_dependency {}
      # end
    end
  end

  describe '#deep_copy' do
    it 'retuns a full copy of the data structure' do
      dataobject.__add_string('key', 'foo')
      copy = dataobject.deep_copy
      expect(copy).to eq(dataobject.data)
      expect(copy).not_to be(dataobject.data)
      copy['key'] << 'bar'
      expect(copy).not_to eq(dataobject.data)
      dataobject.data.delete('key')
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
      expect { dataobject.__exclusive_key_error(keys[0], keys[1..-1]) }.to raise_error
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
      expect(dataobject.data['key']).to eq(some_array_of_ints.map(&:to_s))
      dataobject.data.delete('key')
    end

    it 'raises an error if the values cannot be turned in to an Array' do
      expect { dataobject.__add_array_of_strings('key', 'some string') }.to raise_error
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
      expect { dataobject.__add_array_of_array_of_strings('key', 'some string') }.to raise_error
    end

    it 'raises an error if any element in the values argument is not an array' do
      expect { dataobject.__add_array_of_array_of_strings('key', [['legal'], 'illegal']) }.to raise_error
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
      expect { dataobject.__add_integer('key', StandardError.new("not convertable")) }.to raise_error
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

  describe '#__add_json' do
    it 'assigns a hash to a key' do
      dataobject.__add_json('key', some_hash_of_mixed)
      expect(dataobject.data['key']).to eq(some_hash_of_mixed)
      dataobject.data.delete('key')
    end

    it 'import the hash as it is and assigns them to key' do
      dataobject.__add_json('key', some_hash_of_mixed)
      expect(dataobject.data['key']).to eq(some_hash_of_mixed)
      dataobject.data.delete('key')
    end

    it 'raises an error if the values argument is not a Hash' do
      expect { dataobject.__add_json('key', 'some string') }.to raise_error
    end
  end

  describe '#__add_hash' do
    it 'assigns a hash to a key' do
      dataobject.__add_hash('key', some_hash_of_strings)
      expect(dataobject.data['key']).to eq(some_hash_of_strings)
      dataobject.data.delete('key')
    end

    it 'converts a hash of non-strings to strings and assigns them to key' do
      dataobject.__add_hash('key', some_hash_of_mixed)
      expect(dataobject.data['key']).to eq(some_hash_of_strings)
      dataobject.data.delete('key')
    end

    it 'raises an error if the values argument is not a Hash' do
      expect { dataobject.__add_hash('key', 'some string') }.to raise_error
    end
  end

  describe '#__add_array_of_hashes' do
    it 'assigns an array of hashes to a key' do
      array = [some_hash_of_strings, some_hash_of_strings]
      dataobject.__add_array_of_hashes('key', array)
      expect(dataobject.data['key']).to eq(array)
      dataobject.data.delete('key')
    end

    it 'converts non-strings in the hashes to strings during assignment to key' do
      array = [some_hash_of_mixed, some_hash_of_mixed]
      dataobject.__add_array_of_hashes('key', array)
      expect(dataobject.data['key']).to eq([some_hash_of_strings, some_hash_of_strings])
      dataobject.data.delete('key')
    end

    it 'raises an error if the values argument is not an array' do
      expect { dataobject.__add_array_of_hashes('key', 'some string') }.to raise_error
    end

    it 'raises an error if any element in the values argument is not a Hash' do
      expect { dataobject.__add_array_of_hashes('key', [some_hash_of_strings, 'illegal']) }.to raise_error
    end
  end

  describe '#__add_array_of_ints' do
    it 'assigns an array of ints to a key' do
      array = some_array_of_ints
      dataobject.__add_array_of_ints('key', array)
      expect(dataobject.data['key']).to eq(array)
      dataobject.data.delete('key')
    end

    it 'raises error if the values argument is not an array' do
      expect { dataobject.__add_array_of_ints('key', some_hash_of_strings) }.to raise_error
    end

    it 'raises error if the array contains non-integer strings' do
      expect { dataobject._add_array_of_ints('key', some_array_of_strings) }.to raise_error
    end
  end
end
