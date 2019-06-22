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

  def create_spa
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      head :ok
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_url
  end

  def destroy_spa
    session[:user_id] = nil
    head :ok
  end
end
