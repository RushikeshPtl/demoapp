class LoginController < ApplicationController
    protect_from_forgery with: :null_session
    #before_action :authenticate_request!

    def hello
    end

    def sign_in
        @user = User.find_by_username(login_params[:username])
        if @user
            if @user[:status_active] == 1
                if @user.valid_password?(login_params[:password])
                    render json: "Logged In As #{@user[:name]}"
                else
                    render json: "Password Incorrect #{@user[:password]} , #{login_params[:password]}"
                end
            else
                render json: "Status is 0"
            end
        else
            render json: "User Not Exist"
        end
    end

    private
    def login_params
        params.permit(:username, :password)
    end
end
