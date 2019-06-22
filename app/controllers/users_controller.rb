class UsersController < ApplicationController
  before_action :check_registration_is_open, only: [:create]
  def new
    @user = User.new
  end

  def create
    if params.empty?
      render 'users/new'
    end
    @user = User.new(user_params)
    if @user.save
      redirect_to sessions_new_url
    else
      redirect_to users_new_url, notice: @user.errors.full_messages
    end
  end

  def create_spa
    @user = User.new(user_params)
    if @user.save
      head :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def check_registration_is_open
      unless Setting.registration_open
        head :forbidden
      end
    end

    def user_params
      params.require(:user).permit(:username, :name, :surname, :password, :password_confirmation)
    end
end
