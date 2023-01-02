# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/car'
require './lib/models/rental'
require './lib/models/option'
require './lib/services/calculate_commission'

RSpec.describe CalculateCommission do
  describe '#call' do
    subject(:calculate) { described_class.new(car, rental, all_fees: all_fees, options: options) }
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
    let(:options) { nil }
    let(:all_fees) { false }

    context 'when all fees are included' do
      let(:all_fees) { true }

      it 'outputs the commission for the rentals including the fees' do
        expect(calculate.call).to eq({
                                       commission:
                                         {
                                           insurance_fee: 450,
                                           assistance_fee: 100,
                                           drivy_fee: 350,
                                           owner_fee: 2100,
                                           price: 3000
                                         }
                                     })
      end
    end

    context 'when all fees are not included' do
      let(:all_fees) { false }

      it 'outputs the commission for the rentals excluding the fees' do
        expect(calculate.call).to eq({
                                       commission: {
                                         insurance_fee: 450,
                                         assistance_fee: 100,
                                         drivy_fee: 350
                                       }
                                     })
      end
    end

    context 'when the options are included' do
      let(:all_fees) { true }
      let(:options) do
        [
          Option.new(id: 1, rental_id: 1, type: 'gps'),
          Option.new(id: 2, rental_id: 1, type: 'baby_seat')
        ]
      end

      it 'outputs the updated commission fees' do
        expect(calculate.call).to eq({
                                       commission: {
                                         insurance_fee: 450,
                                         assistance_fee: 100,
                                         drivy_fee: 350,
                                         owner_fee: 2800,
                                         price: 3700
                                       }
                                     })
      end
    end
  end
end
