# frozen_string_literal: true

require 'active_model'

class Car
  include ActiveModel::Model

  attr_accessor :id, :price_per_day,:price_per_km


  validates :id, :price_per_day,:price_per_km, presence: true
end
