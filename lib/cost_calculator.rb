require 'date'
require 'json'

class CostCalculator
  def initialize(cars,
                 rentals,
                 apply_discounts: false,
                 calculate_commission: false)

    @cars = cars
    @rentals = rentals
    @apply_discounts = apply_discounts
    @calculate_commission = calculate_commission
  end

  def call
    rentals_output = { rentals: [] }
    rentals_output[:rentals] = rentals.map do |rental|
      car = cars.find {|car| car.id == rental.car_id }

      cost_per_days = CostPerDay.new(car, rental, apply_discounts: apply_discounts).call

      cost_for_distance = car.price_per_km * rental.distance
      price = (cost_per_days + cost_for_distance)

      rental_output = {
        id: rental.id,
        price: price,
      }

      if calculate_commission
        rental_output = rental_output.merge!(
          CalculateCommission.new(price, rental).call
        )
      end

      rental_output
    end

    JSON.generate(rentals_output)
  end

  private
  attr_reader :apply_discounts, :cars, :rentals, :calculate_commission

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

  class CalculateCommission
    def initialize(price, rental)
      @price = price
      @rental = rental
    end

    def call
      commission_amount = price * 0.30
      insurance_fee = (commission_amount * 0.5).to_i
      days = (Date.parse(rental.start_date)..Date.parse(rental.end_date)).count
      assistance_fee = (days * 100)
      drivy_fee = (commission_amount - (insurance_fee + assistance_fee)).to_i

      {
        commission: {
          insurance_fee:  insurance_fee,
          assistance_fee: assistance_fee,
          drivy_fee:      drivy_fee
        }
      }
    end

    private
    attr_reader :price, :rental
  end
end