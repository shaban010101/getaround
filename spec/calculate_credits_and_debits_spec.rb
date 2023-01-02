# frozen_string_literal: true

require './spec/spec_helper'
require './lib/car'
require './lib/rental'
require './lib/calculate_credits_and_debits'

RSpec.describe CalculateCreditsAndDebits do
  describe '#call' do
    subject(:calculate) { described_class.new(car, rental) }
    let(:car) do
      Car.new(
        id: 1,
        price_per_day: 2000,
        price_per_km: 10
      )
    end
    let(:rental) do
      Rental.new(
        id: 1,
        car_id: 1,
        start_date: '2015-12-8',
        end_date: '2015-12-8',
        distance: 100
      )
    end

    it 'outputs the credits and debits for the rentals' do
      expect(calculate.call).to eq(
        {
          id: 1,
          actions: [
            {
              who: 'driver',
              type: 'debit',
              amount: 3000
            },
            {
              who: 'owner',
              type: 'credit',
              amount: 2100
            },
            {
              who: 'insurance',
              type: 'credit',
              amount: 450
            },
            {
              who: 'assistance',
              type: 'credit',
              amount: 100
            },
            {
              who: 'drivy',
              type: 'credit',
              amount: 350
            }
          ]
        }
      )
    end
  end
end
