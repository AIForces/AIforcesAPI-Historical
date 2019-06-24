class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :current_user
  helper_method :check_logged_in
  helper_method :is_admin?
  helper_method :check_admin
  helper_method :current_event

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_logged_in
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  def is_admin?
    not current_user.nil? and current_user.role == 'admin'
  end

  def check_admin
    unless is_admin?
      head :forbidden
    end
  end



  def current_event
    @current_event = Event.find(Setting.default_event)
  end
end
