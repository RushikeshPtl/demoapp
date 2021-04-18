class Bus < ApplicationRecord
    validates_presence_of :route_name
    validates_numericality_of :ticket_price
    validates_numericality_of :seat_capacity
end
