class UserController < ApplicationController
    skip_before_action :verify_authenticity_token

    def welcome
    end

    def new
    end
    
    def register_user
        @user = User.new(user_params)
        #@user[:date_created] = Time.zone.local_to_utc(Time.new)
        if @user.save
            render json: "User Registered Successfully"
        else 
            render json: "Can Not Add User"
        end
    end

    def activate_user
        @user = User.find_by_email(params[:email])
        @user[:status_active] = 1
        if @user.save
            render json: "User Activated.....Now user can login"
        else
            render json: "Can Not Activate User....Please check email address"
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :name, :city, :registration_country, :contact_number)
    end

end
