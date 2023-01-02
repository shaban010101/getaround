# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/rental'

RSpec.describe Rental do
  subject(:rental) do
    described_class.new(
      id: 1,
      car_id: 2,
      start_date: '30/12/2022',
      end_date: '31/12/2022',
      distance: 90
    )
  end

  describe 'validations' do
    it 'valid with attributes' do
      expect(rental).to be_valid
    end

    it 'invalid with nil' do
      rental.id = nil
      expect(rental).to_not be_valid
    end

    it 'invalid with nil' do
      rental.car_id = nil
      expect(rental).to_not be_valid
    end

    describe 'distance' do
      it 'invalid with nil' do
        rental.distance = nil
        expect(rental).to_not be_valid
      end

      it 'invalid with a non date' do
        rental.distance = 'SHOW'
        expect(rental).to_not be_valid
      end
    end

    describe 'start_date' do
      it 'invalid with nil' do
        rental.start_date = nil
        expect(rental).to_not be_valid
      end

      it 'invalid when not a date' do
        rental.start_date = 'IS'
        expect(rental).to_not be_valid
        expect(rental.errors.map(&:message)).to include('Must have valid dates')
      end
    end

    describe 'end_date' do
      it 'invalid with nil' do
        rental.end_date = nil
        expect(rental).to_not be_valid
      end

      it 'invalid with date greater than start_date' do
        rental.start_date = '12/12/2022'
        rental.end_date = '11/12/2022'
        expect(rental).to_not be_valid
        expect(rental.errors.map(&:message)).to include('must be after the start date')
      end

      it 'invalid when not a date' do
        rental.end_date = 'IS'
        expect(rental).to_not be_valid
        expect(rental.errors.map(&:message)).to include('Must have valid dates')
      end
    end
  end
end
