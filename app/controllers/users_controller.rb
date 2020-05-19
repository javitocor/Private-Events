class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      login(@user)
      current_user
      redirect_to @user
    else 
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @past_events = @user.attended_events.past_events
    @upcoming_events = @user.attended_events.upcoming_events 
  end

  private

  def user_params 
    params.require(:user).permit(:name, :email)
  end
  
end
