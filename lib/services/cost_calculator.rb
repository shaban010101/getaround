# frozen_string_literal: true

require 'json'
require './lib/services/cost_per_day'

class CostCalculator
  def initialize(cars,
                 rentals,
                 apply_discounts: false)

    @cars = cars
    @rentals = rentals
    @apply_discounts = apply_discounts
  end

  def call
    rentals_output = rentals.each_with_object({ rentals: [] }) do |rental, collection|
      selected_car = cars.find { |car| car.id == rental.car_id }
      collection[:rentals] << {
        id: rental.id,
        price: price(selected_car, rental)
      }
    end

    JSON.generate(rentals_output)
  end

  private

  attr_reader :apply_discounts, :cars, :rentals

  def price(car, rental)
    cost_per_days = CostPerDay.new(car, rental, apply_discounts: apply_discounts).call

    cost_for_distance = car.price_per_km * rental.distance

    cost_per_days + cost_for_distance
  end
end
