# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/cars'
require './lib/models/car'

RSpec.describe Cars do
  subject(:cars) do
    described_class.new([car])
  end
  context 'valid rental' do
    let(:car) do
      {
        id: 1, price_per_day: 200, price_per_km: 30
      }
    end

    it 'outputs the valid rentals' do
      expect(cars.output.first).to be_a(Car)
    end
  end

  context 'invalid rental' do
    let(:car) do
      {
        id: 1, price_per_day: 200, price_per_km: nil
      }
    end

    it 'outputs empty rentals' do
      expect(cars.output).to eq([])
    end

    it 'outputs the error' do
      expect { cars.output }.to output("Car ID 1\nPrice per km is not a number\n").to_stdout
    end
  end
end
