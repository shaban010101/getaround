# frozen_string_literal: true

require './spec/spec_helper'
require './lib/cost_calculator'
require './lib/car'
require './lib/rental'

RSpec.describe CostCalculator do
  subject(:calculate) do
    described_class.new(
      cars,
      rentals,
      apply_discounts: apply_discounts,
    )
  end
  let(:rentals) do
    [
      Rental.new(id: 1,
                 car_id: 1,
                 start_date: "2015-07-3",
                 end_date: "2015-07-14",
                 distance: 1000)
    ]
  end
  let(:cars) do
    [
      Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    ]
  end
  let(:apply_discounts) { false }

  describe 'call' do
    it 'outputs the cost of rentals' do
      expect(calculate.call).to eq(JSON.generate({rentals: [{ id: 1, price: 34000}]}))
    end

    context 'when discounts are applied' do
      let(:apply_discounts) { true }

      it 'outputs the cost of rentals' do
        expect(calculate.call).to eq(JSON.generate({rentals: [{ id: 1, price: 27800}]}))
      end
    end
  end
end