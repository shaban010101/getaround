# frozen_string_literal: true

class CostPerDay
  DISCOUNTS = [
    { days: 1, amount: 10 },
    { days: 4, amount: 30 },
    { days: 10, amount: 50 }
  ].freeze

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

  private

  attr_reader :apply_discounts, :car, :rental

  def apply_discount(days, car)
    return car.price_per_day if days == 1

    calculate_discount(days)
  end

  def calculate_discount(days)
    Range.new(1, days).inject(0) do |total, day|
      amounts = select_discounts(day)

      amounts = [{ amount: 0 }] if amounts.empty?

      amount = take_highest_discount(amounts)

      total + (1 * (car.price_per_day * ((100 - amount) / 100.to_d)))
    end
  end

  def select_discounts(day)
    DISCOUNTS.select { |discount| day > discount[:days] }
  end

  def take_highest_discount(amounts)
    amounts.max { |a, b| a[:amount] <=> b[:amount] }[:amount]
  end
end
