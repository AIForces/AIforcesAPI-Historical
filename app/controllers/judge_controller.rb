require 'net/http'
require 'json'

class JudgeController < ApplicationController
  before_action :check_trusted_ip
  force_ssl except: [:receive_data, :receive_status]
  include Judge


  private

  def check_trusted_ip
    unless Setting.trusted_ips.include? request.remote_ip
      head :forbidden
    end
  end
end