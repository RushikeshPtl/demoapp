class AuthenticationController < ApplicationController
    protect_from_forgery with: :null_session

    def log_in 
    end

    def authenticate_user
        user = User.find_by_email(auth_params[:email])
        if user.valid_password?(auth_params[:password])
            token = payload(user)
            session[:user_id] = user.id
            current_user
            redirect_to :action => "list", :controller => "booking"
            #render json: @current_user
        else
            render json: {errors: ['Invalid Username/Password'], status: :Unauthorized}
        end
    end

    def log_out
        session[:user_id] = nil
        redirect_to :action=> "welcome", :controller=>'user'
    end

    private
    def auth_params
        params.require(:user).permit(:email, :password)
    end

    def payload(user)
        return nil unless user and user.id
        {
            auth_token: JsonWebToken.encode({user_id: user.id}),
            user: {id: user.id, email: user.email}
        }
    end
end
