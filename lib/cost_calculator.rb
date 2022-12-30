require 'date'
require 'json'

class CostCalculator
  def initialize(cars, rentals)
    @cars = cars
    @rentals = rentals
  end

  def call
    rentals_output = { rentals: [] }
    rentals_output[:rentals] = rentals.map do |rental|
      car  = cars.find {|car| car.id == rental.car_id }

      cost_per_days = CostPerDay.new(car, rental).call

      cost_for_distance = car.price_per_km * rental.distance

      {
        "id" => rental.id,
        "price" => (cost_per_days + cost_for_distance)
      }
    end
    JSON.generate(rentals_output)
  end

  private
  attr_reader :cars, :rentals

  class CostPerDay
    def initialize(car, rental)
      @car = car
      @rental = rental
    end

    def call
      days = (Date.parse(rental.start_date)..Date.parse(rental.end_date)).count

      days *  car.price_per_day
    end

    attr_reader :car, :rental
  end
end