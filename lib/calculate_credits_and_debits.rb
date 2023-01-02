require './lib/cost_calculator'
require './lib/calculate_commission'

class CalculateCreditsAndDebits
  KEY_TRANSLATIONS = {
    :driver => :price,
    :owner => :owner_fee,
    :insurance => :insurance_fee,
    :assistance => :assistance_fee,
    :drivy => :drivy_fee
  }

  ACTIONS = {
    :driver => {
      who: "driver",
      type: "debit"
    },
    :owner => {
      who: "owner",
      type: "credit"
    },
    :insurance => {
      "who": "insurance",
      "type": "credit"
    },
    :assistance => {
      "who": "assistance",
      "type": "credit",
    },
    :drivy => {
      "who": "drivy",
      "type": "credit",
    }
  }

  def initialize(car, rental)
    @car = car
    @rental = rental
  end

  def call
    commission = CalculateCommission.new(car, rental, all_fees: true).call[:commission]

    {
      id: rental.id,
      actions: ACTIONS.map do |key, values|
        { amount: commission[KEY_TRANSLATIONS[key]] }.merge!(values)
      end
    }

  end

  private
  attr_reader :rental, :car

  def price
    cost_per_day = CostCalculator::CostPerDay.new(car, rental, apply_discounts: true).call

    cost_for_distance = car.price_per_km * rental.distance

    (cost_per_day + cost_for_distance)
  end
end
