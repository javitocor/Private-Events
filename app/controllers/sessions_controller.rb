class SessionsController < ApplicationController

    def new        
    end

    def create 
        user = User.find_by_name(params[:session][:name])
        if user 
            login(user)
            current_user
            redirect_to user
        else
            render 'new'
        end
    end 

    def destroy
        logout
        redirect_to root_path
    end

end
