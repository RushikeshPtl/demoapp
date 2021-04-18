class BookingController < ApplicationController
    skip_before_action :verify_authenticity_token
    def list
        @buses = Bus.all
    end

    def create_bus
        route = bus_params[:route_name]
        t = Time.new
        start_time = Time.zone.local_to_utc(Time.new(t.year, t.month, t.day+1, 11, 0, 0))
        end_time = Time.zone.local_to_utc(Time.new(t.year, t.month, t.day+1, start_time.hour + bus_params[:trip_time], 0, 0))
        cost = bus_params[:ticket_price]
        seats = bus_params[:seat_capacity]
        @bus = Bus.new({"route_name"=>route, "trip_start_time"=> start_time.to_datetime, "trip_end_time"=>end_time.to_datetime, "ticket_price"=>cost, "seat_capacity"=>seats})
        if @bus.save
            render json: "Bus Added Successfully"
        else
            render json: @bus
        end
    end

    def book_trip
    end


    private
    def bus_params
        params.require(:bus).permit(:route_name, :trip_time, :ticket_price, :seat_capacity)
    end
end
