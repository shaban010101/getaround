# frozen_string_literal: true

require './lib/services/cost_per_day'
require './lib/services/calculate_commission'

class CalculateCreditsAndDebits
  KEY_TRANSLATIONS = {
    driver: :price,
    owner: :owner_fee,
    insurance: :insurance_fee,
    assistance: :assistance_fee,
    drivy: :drivy_fee
  }.freeze

  ACTIONS = {
    driver: {
      who: 'driver',
      type: 'debit'
    },
    owner: {
      who: 'owner',
      type: 'credit'
    },
    insurance: {
      "who": 'insurance',
      "type": 'credit'
    },
    assistance: {
      "who": 'assistance',
      "type": 'credit'
    },
    drivy: {
      "who": 'drivy',
      "type": 'credit'
    }
  }.freeze

  def initialize(car, rental, options: nil)
    @car = car
    @rental = rental
    @options = options
  end

  def call
    output = {
      id: rental.id,
      actions: ACTIONS.map do |key, values|
                 { amount: commission(car, rental)[KEY_TRANSLATIONS[key]] }.merge!(values)
               end
    }
    output.merge!({ options: selected_options(options).map(&:type) }) if options
    output
  end

  private

  attr_reader :rental, :car, :options

  def commission(car, rental)
    CalculateCommission.new(car, rental, options: selected_options(options), all_fees: true).call[:commission]
  end

  def selected_options(options)
    options&.select { |option| option.rental_id == rental.id }
  end

  def price
    cost_per_day = CostPerDay.new(car, rental, apply_discounts: true).call

    cost_for_distance = car.price_per_km * rental.distance

    (cost_per_day + cost_for_distance)
  end
end
