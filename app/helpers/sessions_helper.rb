module SessionsHelper

    def login(user)
        session[:user_id] = user.id 
    end

    def logout 
        session[:user_id] = nil
        @current_user = nil
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        end
    end
end
