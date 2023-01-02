# frozen_string_literal: true

require './spec/spec_helper'
require './lib/car'
require './lib/rental'
require './lib/commission_presenter'
require 'json'

RSpec.describe CommissionPresenter do
  subject(:present) { described_class.new(cars, rentals) }

  describe '#call' do
    let(:cars) do
      [Car.new(
        id: 1,
        price_per_day: 2000,
        price_per_km: 10
      )]
    end
    let(:rentals) do
      [Rental.new(
        id: 1,
        car_id: 1,
        start_date: '2015-12-8',
        end_date: '2015-12-8',
        distance: 100
      )]
    end

    it 'outputs the credits and debits for the rentals' do
      expect(JSON.parse(present.call).deep_symbolize_keys!).to eq({
        rentals: [{
          id: 1,
          price: 3000,
          commission:
            {
              insurance_fee: 450,
              assistance_fee: 100,
              drivy_fee: 350,
            }
      }]})
    end
  end
end