# frozen_string_literal: true

require_relative 'car'

class Cars
  def initialize(cars)
    @cars = cars
  end

  def output
    cars.map do |car|
      validated_car = Car.new(id: car[:id],
                              price_per_day: car[:price_per_day],
                              price_per_km: car[:price_per_km])

      unless validated_car.valid?
        puts "Car ID #{car[:id]}", validated_car.errors.map(&:full_message)
        next
      end

      validated_car
    end.compact
  end

  private

  attr_reader :cars
end
