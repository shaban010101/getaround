# frozen_string_literal: true

require './spec/spec_helper'
require './lib/car'
require './lib/rental'
require './lib/calculate_commission'

RSpec.describe CalculateCommission do
  describe '#call' do
    subject(:calculate) { described_class.new(car, rental, all_fees: all_fees) }
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

    context 'when all fees are included' do
      let(:all_fees) { true }

      it 'outputs the credits and debits for the rentals' do
        expect(calculate.call).to eq({
          commission:
            {
               insurance_fee: 450,
               assistance_fee: 100,
               drivy_fee: 350,
               owner_fee: 2100,
               price: 3000,
           }
        })
      end
    end

    context 'when all fees are not included' do
      let(:all_fees) { false }

      it 'outputs the credits and debits for the rentals' do
        expect(calculate.call).to eq({
          commission: {
            insurance_fee: 450,
            assistance_fee: 100,
            drivy_fee: 350,
           }
        })
      end
    end
  end
end