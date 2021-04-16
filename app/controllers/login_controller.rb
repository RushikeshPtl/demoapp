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

    def forgot_password
    end

    def rp_token
        if forgot_params[:email].blank?
            return render json: {error: 'Email Not Present'}
        end
        @user = User.find_by_email(forgot_params[:email])
        if @user.present?
            @user.generate_password_token!
            @token = @user[:reset_password_token]
        else
            render json: "User Not found"
        end
    end

    def new_password
    end

    def reset
        token = reset_params[:reset_password_token].to_s
    
        @user = User.find_by_reset_password_token(token)
    
        if @user 
            if reset_params[:new_password] == reset_params[:confirm_new_password]
                if @user.reset_password!(reset_params[:new_password])
                    render json: {status: 'ok'}, status: :ok
                else
                    render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
                end 
            else 
                render json: "Password not confirmed"
            end
        else
          render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
        end
    end

    private
    def login_params
        params.require(:user).permit(:username, :password)
    end

    def forgot_params
        params.require(:user).permit(:email)
    end

    def reset_params
        params.require(:user).permit(:reset_password_token, :new_password, :confirm_new_password)
    end
end
