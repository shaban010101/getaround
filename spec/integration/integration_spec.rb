# frozen_string_literal: true

require './spec/spec_helper'
require 'json'

RSpec.describe 'Integration' do
  context 'level 1' do
    let(:expected_output) do
      open_file('./lib/level1/data/expected_output.json')
    end

    after do
      delete_file('./lib/level1/data/output.json')
    end

    it 'outputs the correct values' do
      `ruby ./lib/level1/main.rb level1/data/input.json`

      output = open_file('./lib/level1/data/output.json')

      expect(output).to include_json(expected_output)
    end
  end

  context 'level 2' do
    let(:expected_output) do
      open_file('./lib/level2/data/expected_output.json')
    end

    after do
      delete_file('./lib/level2/data/output.json')
    end

    it 'outputs the correct values' do
      `ruby ./lib/level2/main.rb level2/data/input.json`

      output = open_file('./lib/level2/data/output.json')

      expect(output).to include_json(expected_output)
    end
  end

  context 'level 3' do
    let(:expected_output) do
      open_file('./lib/level3/data/expected_output.json')
    end

    after do
      delete_file('./lib/level3/data/output.json')
    end

    it 'outputs the correct values' do
      `ruby ./lib/level3/main.rb level3/data/input.json`

      output = open_file('./lib/level3/data/output.json')

      expect(output).to include_json(expected_output)
    end
  end

  context 'level 4' do
    let(:expected_output) do
      open_file('./lib/level4/data/expected_output.json')
    end

    after do
      delete_file('./lib/level4/data/output.json')
    end

    it 'outputs the correct values' do
      `ruby ./lib/level4/main.rb level4/data/input.json`

      output = open_file('./lib/level4/data/output.json')

      expect(output).to include_json(expected_output)
    end
  end

  context 'level 5' do
    let(:expected_output) do
      open_file('./lib/level5/data/expected_output.json')
    end

    after do
      delete_file('./lib/level5/data/output.json')
    end

    it 'outputs the correct values' do
      `ruby ./lib/level5/main.rb level5/data/input.json`

      output = open_file('./lib/level5/data/output.json')

      expect(output).to include_json(expected_output)
    end
  end

  def open_file(file_name)
    File.open(file_name) do |f|
      JSON.parse(f.read)
    end
  end

  def delete_file(file_name)
    File.delete(file_name)
  end
end
