# frozen_string_literal: true

require './lib/services/cost_per_day'

class CalculateCommission
  OWNER_OPTIONS = {
    gps: 500,
    baby_seat: 200
  }.freeze
  COMPANY_EXTRAS = { additional_insurance: 1000 }.freeze
  OWNER_PERCENTAGE = 0.7
  COMMISSION_PERCENTAGE = 0.3
  INSURANCE_PERCENTAGE = 0.5

  def initialize(car, rental, options: nil, all_fees: false)
    @car = car
    @rental = rental
    @all_fees = all_fees
    @options = options
  end

  def call
    commission = {
      commission: {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: drivy_fee
      }
    }
    commission[:commission].merge!({ owner_fee: owner_fee, price: rental_price }) if all_fees
    commission
  end

  def rental_price
    (base_cost + owner_options_fee + company_extra_fee)
  end

  private

  def base_cost
    cost_per_day = CostPerDay.new(car, rental, apply_discounts: true).call

    cost_for_distance = car.price_per_km * rental.distance

    cost_per_day + cost_for_distance
  end

  def owner_options_fee
    return 0 unless options

    options.select { |option| OWNER_OPTIONS.include?(option.type.to_sym) }.inject(0) do |total, option|
      total + (OWNER_OPTIONS[option.type.to_sym] * days)
    end
  end

  def owner_fee
    ((base_cost * OWNER_PERCENTAGE) + owner_options_fee).to_i
  end

  def days
    (Date.parse(rental.start_date)..Date.parse(rental.end_date)).count
  end

  def drivy_fee
    (commission_amount - (insurance_fee + assistance_fee)).to_i + company_extra_fee
  end

  def company_extra_fee
    return 0 unless options

    options.select { |option| COMPANY_EXTRAS.include?(option.type.to_sym) }
           .inject(0) do |total, option|
      total + (COMPANY_EXTRAS[option.type.to_sym] * days)
    end
  end

  def commission_amount
    base_cost * COMMISSION_PERCENTAGE
  end

  def insurance_fee
    (commission_amount * INSURANCE_PERCENTAGE).to_i
  end

  def assistance_fee
    (days * 100)
  end

  attr_reader :car, :rental, :all_fees, :options
end
