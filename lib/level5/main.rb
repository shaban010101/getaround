# frozen_string_literal: true

require_relative '../models/cars'
require_relative '../models/rentals'
require_relative '../models/option'
require_relative '../presenters/credits_and_debits_presenter'
require 'json'

file_name = ARGV[0]
input_file = File.join(File.dirname(__dir__), file_name)
input = File.open(input_file) do |f|
  JSON.parse(f.read)
end.deep_symbolize_keys!

cars = Cars.new(input[:cars]).output

rentals = Rentals.new(input[:rentals]).output

options = input[:options].map do |option|
  validated_option = Option.new(
    id: option[:id],
    rental_id: option[:rental_id],
    type: option[:type]
  )

  unless validated_option.valid?
    puts "Option ID #{option[:id]}", validated_option.errors.map(&:full_message)
    next
  end

  validated_option
end

result = CreditsAndDebitsPresenter.new(cars, rentals, options: options)

File.write('lib/level5/data/output.json', result.call, mode: 'w')
