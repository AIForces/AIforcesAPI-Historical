class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :check_logged_in

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

  def check_admin
    if current_user.nil or current_user.role != 'admin'
      head :forbidden
    end
  end



  def current_event
    @current_event = Event.find(Setting.default_event)
  end
end
