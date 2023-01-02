# frozen_string_literal: true

require_relative '../models/cars'
require_relative '../models/rentals'
require_relative '../presenters/credits_and_debits_presenter'
require 'json'

file_name = ARGV[0]
input_file = File.join(File.dirname(__dir__), file_name)
input = File.open(input_file) do |f|
  JSON.parse(f.read)
end.deep_symbolize_keys!

cars = Cars.new(input[:cars]).output

rentals = Rentals.new(input[:rentals]).output

result = CreditsAndDebitsPresenter.new(cars, rentals)

File.write('lib/level4/data/output.json', result.call, mode: 'w')
