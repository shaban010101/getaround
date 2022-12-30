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
end
