class UsersController < ApplicationController
  before_action :check_registration_is_open, only: [:create]
  before_action :set_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      head :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    render json: {
        id: @user.id,
        username: @user.username,
        name: @user.name,
        surname: @user.surname,
    }
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
