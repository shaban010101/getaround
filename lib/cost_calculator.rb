require 'date'
require 'json'

class CostCalculator
  def initialize(cars, rentals, apply_discounts: false)
    @cars = cars
    @rentals = rentals
    @apply_discounts = apply_discounts
  end

  def call
    rentals_output = { rentals: [] }
    rentals_output[:rentals] = rentals.map do |rental|
      car = cars.find {|car| car.id == rental.car_id }

      cost_per_days = CostPerDay.new(car, rental, apply_discounts: apply_discounts).call

      cost_for_distance = car.price_per_km * rental.distance

      {
        "id" => rental.id,
        "price" => (cost_per_days + cost_for_distance)
      }
    end
    JSON.generate(rentals_output)
  end

  private
  attr_reader :apply_discounts, :cars, :rentals

  class CostPerDay
    def initialize(car, rental, apply_discounts:)
      @car = car
      @rental = rental
      @apply_discounts = apply_discounts
    end

    def call
      days = (Date.parse(rental.start_date)..Date.parse(rental.end_date)).count
      if apply_discounts
        apply_discount(days, car).to_i
      else
        days * car.price_per_day
      end
    end

    def apply_discount(days, car)
      return car.price_per_day if days == 1

      discount_amounts = [
        { days: 1, amount: 10 },
        { days: 4, amount: 30 },
        { days: 10, amount: 50 }
      ]

       Range.new(1, days).inject(0) do |total,day|

        amounts = discount_amounts.select {|discount| day > discount[:days] }

        amounts = [{ amount: 0 }] if amounts.empty?

        amount = amounts.max {|a, b| a[:amount] <=> b[:amount] }[:amount]

        total + (1 * (car.price_per_day * ((100 - amount)/ 100.to_d)))
      end
    end

    attr_reader :apply_discounts, :car, :rental
  end
end