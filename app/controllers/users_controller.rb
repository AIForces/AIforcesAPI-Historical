class UsersController < ApplicationController
  before_action :check_registration_is_open, only: [:create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'
    @user.save
    redirect_to sessions_new_url
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
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
