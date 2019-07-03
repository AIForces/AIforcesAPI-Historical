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
    par = session_params
    user = User.find_by_username(par[:username])

    if user.nil?
      render json: { errors: ["User not found"] }, status: :bad_request
      return
    end

    if user && user.authenticate(par[:password])
      session[:user_id] = user.id
      head :ok
    else
      render json: { errors: ["Incorrect password"]}, status: :bad_request
    end
  end

  def current
    if current_user.nil?
      render json: { logged_in: false }
    else
      render json: { logged_in: true, id: current_user.id }
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

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
