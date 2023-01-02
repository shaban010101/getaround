# frozen_string_literal: true

require './spec/spec_helper'
require './lib/car'
require './lib/rental'
require './lib/credits_and_debits_presenter'
require 'json'

RSpec.describe CreditsAndDebitsPresenter do
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
        rentals: [
          { id: 1,
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
      ]})
    end
  end
end