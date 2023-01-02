require './lib/calculate_credits_and_debits'

class CreditsAndDebitsPresenter
  def initialize(cars, rentals)
    @cars = cars
    @rentals = rentals
  end

  def call
    rentals_output = rentals.each_with_object({ rentals: [] }) do |rental, collection|
      car = cars.find { |car| car.id == rental.car_id }

      collection[:rentals] << CalculateCreditsAndDebits.new(car, rental).call
    end

    JSON.generate(rentals_output)
  end

  private

  attr_reader :cars, :rentals
end
