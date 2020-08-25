class UsersController < ApplicationController
    before_action :authenticate_user,except: [:create]
    def create
        @user = User.new(user_params)
        
        if @user.save
            auth_token = Knock::AuthToken.new payload: { sub: @user.id }
             render json: {username: @user.username, jwt: auth_token.token}, status: :created
        else
             render json: @user.errors, status: :unprocessable_entity
        end
    end 
    
    
    private 
    def user_params
        params.permit(:username, :email, :password, :password_confirmation)
    end
end
