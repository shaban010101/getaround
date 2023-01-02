require './lib/calculate_commission'
require 'json'

class CommissionPresenter
  def initialize(cars, rentals)
    @cars = cars
    @rentals = rentals
  end

  def call

    output = rentals.each_with_object({ rentals: [] }) do |rental, collection|
      car = cars.find { |_car| _car.id == rental.car_id }
      commission = CalculateCommission.new(car, rental)

      collection[:rentals] << {
        id: rental.id,
        price: commission.price
      }.merge!(commission.call)
    end
    JSON.generate(output)
  end

  private
  attr_reader :cars, :rentals
end