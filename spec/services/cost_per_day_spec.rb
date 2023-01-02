# frozen_string_literal: true

require './spec/spec_helper'
require './lib/services/cost_per_day'
require './lib/models/car'
require './lib/models/rental'

RSpec.describe CostPerDay do
  subject(:calculate) do
    described_class.new(
      car,
      rental,
      apply_discounts: apply_discounts
    )
  end
  let(:rental) do
    Rental.new(id: 1,
               car_id: 1,
               start_date: '2015-07-3',
               end_date: '2015-07-14',
               distance: 1000)
  end
  let(:car) do
    Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
  end
  let(:apply_discounts) { false }

  describe 'call' do
    context 'when the discounts are not applied' do
      it 'outputs the cost of the rentals without a discount' do
        expect(calculate.call).to eq(24_000)
      end
    end

    context 'when the discounts are applied' do
      let(:apply_discounts) { true }

      it 'outputs the cost of the rental with a discount ' do
        expect(calculate.call).to eq(17_800)
      end
    end
  end
end
