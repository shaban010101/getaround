# frozen_string_literal: true

require './spec/spec_helper'
require './lib/cost_calculator'
require './lib/car'
require './lib/rental'

RSpec.describe CostCalculator do
  subject(:calculate) { described_class.new(cars, rentals) }
  let(:rentals) do
    [
      Rental.new(id: 1,
                 car_id: 1,
                 start_date: "2017-12-8",
                 end_date: "2017-12-10",
                 distance: 100)
    ]
  end
  let(:cars) do
    [
      Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    ]
  end

  describe 'call' do
    it 'outputs the cost of rentals' do
      expect(calculate.call).to eq(JSON.generate({rentals: [{ id: 1, price: 7000}]}))
    end
  end
end