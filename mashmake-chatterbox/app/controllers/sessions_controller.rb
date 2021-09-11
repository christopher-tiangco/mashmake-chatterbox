class SessionsController < ApplicationController
    def new
        @loginScreen = true # This instance variable can be used in the main layout (application.html.erb) to indicate that we're rendering the view for this controller/action
    end
    
    def create
        @user = User.find_by(username: params[:session][:username].downcase)
        
        if (@user.nil? || !@user.authenticate(params[:session][:password]))
            redirect_to root_path, alert: "Invalid username / password"
        else
            session[:user_id] = @user.id
            redirect_to chatroom_path
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Successfully logged out"
    end
end