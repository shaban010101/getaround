# frozen_string_literal: true

require 'active_model'

class Option
  include ActiveModel::Model

  attr_accessor :id, :rental_id, :type

  validates :id, :rental_id, presence: true
  validates :type, inclusion: { in: %w[gps baby_seat additional_insurance] }
end
