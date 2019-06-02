class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to event_rules_url
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to event_rules_url
    else
      redirect_to sessions_new_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_url
  end
end
