class AdminController < ApplicationController
  before_action :check_logged_in
  before_action :check_admin
  def setting
  end
end
