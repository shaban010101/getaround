# frozen_string_literal: true

require './lib/services/calculate_credits_and_debits'

class CreditsAndDebitsPresenter
  def initialize(cars, rentals, options: nil)
    @cars = cars
    @rentals = rentals
    @options = options
  end

  def call
    rentals_output = rentals.each_with_object({ rentals: [] }) do |rental, collection|
      selected_car = cars.find { |car| car.id == rental.car_id }

      collection[:rentals] << CalculateCreditsAndDebits.new(selected_car, rental, options: options).call
    end

    JSON.generate(rentals_output)
  end

  private

  attr_reader :cars, :rentals, :options
end
