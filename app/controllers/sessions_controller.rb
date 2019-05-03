class SessionsController < ApplicationController
  def new
  end

  def create
    if current_user
      redirect_to event_index_url
    end
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    else
      flash.now[:alert] = 'Email or pass invalid.'
      redirect_to sessions_new_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_url, notice: "Logged out"
  end
end
