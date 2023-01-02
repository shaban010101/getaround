# frozen_string_literal: true

require 'active_model'

class Rental
  include ActiveModel::Model

  attr_accessor :id, :car_id, :start_date, :end_date, :distance

  validates :id, :car_id, :start_date, :end_date, presence: true
  validates :distance, numericality: { only_numeric: true }
  validate :end_date_after_start_date?
  validate :valid_dates?

  private

  def valid_dates?
    [start_date, end_date].each do |date|
      next if date.nil?

      Date.parse(date)
    rescue ArgumentError
      errors.add :base, 'Must have valid dates'
    end
  end

  def end_date_after_start_date?
    return if start_date.blank? || end_date.blank?

    begin
      return unless Date.parse(end_date) < Date.parse(start_date)
    rescue ArgumentError
      nil
    end

    errors.add :end_date, 'must be after the start date'
  end
end
