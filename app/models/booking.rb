class Booking < ApplicationRecord
    validates_presence_of :bus_id
    validates_presence_of :user_id
    validates_numericality_of :cost_paid
    validates_numericality_of :seats_booked
end
