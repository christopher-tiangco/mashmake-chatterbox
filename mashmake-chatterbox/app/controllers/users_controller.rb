class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, except: [:new, :create]
    
    def new
        @signupScreen = true
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to chatroom_path
        else
            error_full_messages = @user.errors.full_messages
            flash[:alert] = {"messages" => error_full_messages}
            redirect_to signup_path
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:notice] = "Successfully updated profile"
            redirect_to edit_user_path(@user)
        else
            errorMessages = @user.errors.full_messages
            flash[:alert] = {"messages" => errorMessages}
            redirect_to edit_user_path(@user)
        end
    end

    
    private
    
    def set_user
        begin
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            redirect_to root_path
        end
    end
    
    def user_params
        params.require(:user).permit(:name, :username, :password)
    end
    
    def require_same_user
        if current_user != @user
            redirect_to chatroom_path
        end
    end
end