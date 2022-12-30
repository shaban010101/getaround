# frozen_string_literal: true

require './spec/spec_helper'
require './lib/rental'

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

    it 'invalid with nil' do
      rental.start_date = nil
      expect(rental).to_not be_valid
    end

    it 'invalid with nil' do
      rental.end_date = nil
      expect(rental).to_not be_valid
    end
  end
end
