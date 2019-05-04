class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to rules_url
    end
  end

  def create
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
