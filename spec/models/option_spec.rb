# frozen_string_literal: true

require './spec/spec_helper'
require './lib/models/option'

RSpec.describe Option do
  subject(:option) do
    described_class.new(id: 1, rental_id: 1, type: 'gps')
  end

  describe 'validations' do
    it 'valid with attributes' do
      expect(option).to be_valid
    end

    it 'invalid with nil' do
      option.id = nil
      expect(option).to_not be_valid
    end

    it 'invalid with nil' do
      option.rental_id = nil
      expect(option).to_not be_valid
    end

    it 'invalid with nil' do
      option.type = nil
      expect(option).to_not be_valid
    end

    describe 'type' do
      it 'invalid with a non matching type' do
        option.type = 'GPRS'
        expect(option).to_not be_valid
      end
    end
  end
end
