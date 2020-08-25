class UserController < ApplicationController

    
    
    private 
    def user_params
        params.permit(:username, :email, :password, :password_confirmation)
    end
end
