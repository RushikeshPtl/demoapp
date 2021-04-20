class BookingController < ApplicationController
    skip_before_action :verify_authenticity_token
    def list
        @current_user = User.find_by_id(session[:user_id])
        @buses = Bus.order(id: :ASC)
    end

    def add_bus
    end

    def create_bus
        route = bus_params[:route_name]
        t = Time.new
        start_time = Time.zone.local_to_utc(Time.new(t.year, t.month, t.day+1, 11, 0, 0))
        end_time = Time.zone.local_to_utc(Time.new(t.year, t.month, t.day+1, start_time.hour + bus_params[:trip_time].to_i, 0, 0))
        cost = bus_params[:ticket_price]
        seats = bus_params[:seat_capacity]
        @bus = Bus.new({"route_name"=>route, "trip_start_time"=> start_time.to_datetime, "trip_end_time"=>end_time.to_datetime, "ticket_price"=>cost, "seat_capacity"=>seats})
        if @bus.save
            render json: "Bus Added Successfully"
        else
            render json: "Can not add bus"
        end
    end

    def book_trip
        @trip = Bus.find_by_id(params[:bus_id])
        @user = User.find_by_id(params[:user_id])
    end

    def show_details
        @bus = Bus.find_by_id(params[:bus_id])
        @user = User.find_by_id(session[:user_id])
        @seats = params[:seats_booked]
        @bill = params[:bill]
    end

    def initiate_booking
        @trip = Bus.find_by_id(booking_params[:bus_id])
        @user = User.find_by_id(session[:user_id])
        seats_required = booking_params[:seats_required].to_i
        if @trip[:seat_capacity] >= seats_required
            total_bill = @trip[:ticket_price] * seats_required
            redirect_to :action=>'show_details', :bus_id=>@trip.id, :seats_booked=>seats_required, :bill=>total_bill
        else
            render json: "Seats Not Availble"
        end
    end

    def confirm_booking
        bus_id = params[:bus_id]
        user_id = session[:user_id]
        seats_booked = params[:seats_booked].to_i
        total_bill = params[:bill]
        @bus = Bus.find_by_id(bus_id)
        @bus.update({'route_name'=>@bus[:route_name], 'trip_start_time'=>@bus[:trip_start_time], 'trip_end_time'=>@bus[:trip_end_time], 'ticket_price'=>@bus[:ticket_price], 'seat_capacity'=>@bus[:seat_capacity].to_i-seats_booked})
        @booking = Booking.new({'bus_id'=>bus_id, 'user_id'=>user_id, 'cost_paid'=>total_bill, 'seats_booked'=>seats_booked, 'is_canceled'=>0})
        @booking.save
            #render json: "Successful......"
        #end
    end

    def find_bookings
        @bookings = Booking.where({:user_id=>session[:user_id], :is_canceled=>0})
    end

    def cancel_booking
        @bus = Bus.find_by_id(params[:bus_id])
        @bus.update({'seat_capacity'=>@bus[:seat_capacity].to_i+params[:seats_booked].to_i})
        @booking = Booking.find_by_id(params[:booking_id])
        @booking.update({'is_canceled'=>1})
        redirect_to :action=>'find_bookings'
    end
    


    private
    def bus_params
        params.require(:bus).permit(:route_name, :trip_time, :ticket_price, :seat_capacity)
    end

    def booking_params
        params.require(:booking).permit(:bus_id, :seats_required)
    end
end
