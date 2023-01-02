# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/car'

RSpec.describe Car do
  subject(:car) do
    described_class.new(id: 1, price_per_day: 200, price_per_km: 30)
  end

  describe 'validations' do
    it 'valid with attributes' do
      expect(car).to be_valid
    end

    it 'invalid with nil' do
      car.id = nil
      expect(car).to_not be_valid
    end

    describe 'price_per_day' do
      it 'invalid with nil' do
        car.price_per_day = nil
        expect(car).to_not be_valid
      end

      it 'invalid with a string' do
        car.price_per_day = 'MILE'
        expect(car).to_not be_valid
      end
    end

    describe 'price_per_km' do
      it 'invalid with a string' do
        car.price_per_km = 'PER'
        expect(car).to_not be_valid
      end

      it 'invalid with nil' do
        car.price_per_km = nil
        expect(car).to_not be_valid
      end
    end
  end
end
