require './spec/spec_helper'
require 'json'

RSpec.describe 'Integration' do
  context 'level 1' do
    it 'outputs the correct values' do
      expected__output = File.open('./lib/level1/data/expected_output.json') do |f|
        JSON.parse(f.read)
      end
      output = `ruby ./lib/level1/main.rb level1/data/input.json`

      expect(JSON.parse(output)).to eq(expected__output)
    end
  end

  context 'level 2' do
    it 'outputs the correct values' do
      expected__output = File.open('./lib/level2/data/expected_output.json') do |f|
        JSON.parse(f.read)
      end
      output = `ruby ./lib/level2/main.rb level2/data/input.json`

      expect(JSON.parse(output)).to eq(expected__output)
    end
  end

  context 'level 3' do
    it 'outputs the correct values' do
      expected__output = File.open('./lib/level3/data/expected_output.json') do |f|
        JSON.parse(f.read)
      end
      output = `ruby ./lib/level3/main.rb level3/data/input.json`

      expect(JSON.parse(output)).to eq(expected__output)
    end
  end

  context 'level 4' do
    it 'outputs the correct values' do
      expected__output = File.open('./lib/level4/data/expected_output.json') do |f|
        JSON.parse(f.read)
      end

      output = `ruby ./lib/level4/main.rb level4/data/input.json`

      expect(JSON.parse(output)).to match(expected__output)
    end
  end
end
