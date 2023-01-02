# frozen_string_literal: true

require_relative 'rental'

class Rentals
  def initialize(rentals)
    @rentals = rentals
  end

  def output
    rentals.map do |rental|
      validated_rental = Rental.new(
        id: rental[:id],
        car_id: rental[:car_id],
        start_date: rental[:start_date],
        end_date: rental[:end_date],
        distance: rental[:distance]
      )

      unless validated_rental.valid?
        puts "Rental ID #{rental[:id]}", validated_rental.errors.map(&:full_message)
        next
      end

      validated_rental
    end.compact
  end

  private

  attr_reader :rentals
end
