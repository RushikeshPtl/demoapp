class AuthenticationController < ApplicationController
    protect_from_forgery with: :null_session
    def authenticate_user
        user = User.find_by_email(params[:email])
        if user.valid_password?(params[:password])
            render json: payload(user)
        else
            render json: {errors: ['Invalid Username/Password'], status: :Unauthorized}
        end
    end

    private
    def payload(user)
        return nil unless user and user.id
        {
            auth_token: JsonWebToken.encode({user_id: user.id}),
            user: {id: user.id, email: user.email}
        }
    end
end
