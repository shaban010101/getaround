# frozen_string_literal: true

require 'active_model'

class Car
  include ActiveModel::Model

  attr_accessor :id, :price_per_day, :price_per_km

  validates :id, presence: true
  validates :price_per_day, :price_per_km, numericality: { only_numeric: true }
end
