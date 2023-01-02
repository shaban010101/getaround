# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/rentals'
require './lib/models/rental'

RSpec.describe Rentals do
  subject(:rentals) do
    described_class.new([rental])
  end
  context 'valid rental' do
    let(:rental) do
      {
        id: 1,
        car_id: 2,
        start_date: '30/12/2022',
        end_date: '31/12/2022',
        distance: 90
      }
    end

    it 'outputs the valid rentals' do
      expect(rentals.output.first).to be_a(Rental)
    end
  end

  context 'invalid rental' do
    let(:rental) do
      {
        id: 1,
        car_id: 2,
        start_date: '30/12/2022',
        end_date: '',
        distance: 90
      }
    end

    it 'outputs the empty rentals' do
      expect(rentals.output).to eq([])
    end

    it 'outputs the error' do
      expect { rentals.output }
        .to output("Rental ID 1\nEnd date can't be blank\nMust have valid dates\n").to_stdout
    end
  end
end
