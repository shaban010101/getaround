require_relative '../car'
require_relative '../rental'
require_relative '../cost_calculator'
require 'json'

file_name = ARGV[0]
input_file = File.join(File.dirname(__dir__), file_name)
input = File.open(input_file) do |f|
  JSON.parse(f.read)
end.deep_symbolize_keys!

cars = input[:cars].map do |car|
  Car.new(
    id: car[:id],
    price_per_day: car[:price_per_day],
    price_per_km: car[:price_per_km]
  )
end

rentals = input[:rentals].map do |rental|
  Rental.new(
    id: rental[:id],
    car_id: rental[:car_id],
    start_date: rental[:start_date],
    end_date: rental[:end_date],
    distance: rental[:distance]
  )
end

result = CostCalculator.new(cars, rentals)

puts result.call
