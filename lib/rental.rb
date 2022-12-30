require 'active_model'

class Rental
  include ActiveModel::Model

  attr_accessor :id, :car_id, :start_date, :end_date, :distance

  validates :id, :car_id, :start_date, :end_date, :distance, presence: true
end