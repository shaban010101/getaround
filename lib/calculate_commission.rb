require './lib/cost_calculator'

class CalculateCommission
  def initialize(car, rental, all_fees: false)
    @car = car
    @rental = rental
    @all_fees = all_fees
  end

  def call
    commission_amount = price * 0.30
    insurance_fee = (commission_amount * 0.5).to_i
    days = (Date.parse(rental.start_date)..Date.parse(rental.end_date)).count
    assistance_fee = (days * 100)
    drivy_fee = (commission_amount - (insurance_fee + assistance_fee)).to_i

    commission = {
      commission: {
        insurance_fee:  insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee:      drivy_fee,
      }
    }
    commission[:commission].merge!({ owner_fee: (price * 0.7).to_i, price: price }) if all_fees
    commission
  end

  def price
    cost_per_day = CostCalculator::CostPerDay.new(car, rental, apply_discounts: true).call

    cost_for_distance = car.price_per_km * rental.distance

    (cost_per_day + cost_for_distance)
  end

  private
  attr_reader :car, :rental, :all_fees
end
