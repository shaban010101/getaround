# frozen_string_literal: true

require './lib/services/calculate_commission'
require 'json'

class CommissionPresenter
  def initialize(cars, rentals)
    @cars = cars
    @rentals = rentals
  end

  def call
    output = rentals.each_with_object({ rentals: [] }) do |rental, collection|
      selected_car = cars.find { |car| car.id == rental.car_id }
      commission = CalculateCommission.new(selected_car, rental)

      collection[:rentals] << {
        id: rental.id,
        price: commission.rental_price
      }.merge!(commission.call)
    end
    JSON.generate(output)
  end

  private

  attr_reader :cars, :rentals
end
