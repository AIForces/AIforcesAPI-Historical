require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_trusted_ip
  force_ssl except: [:receive_data, :receive_status]
  include Judge

  def receive_data
    # Not safe, but so good!
    Rails.logger.debug("Permitting parameters")
    params.permit!
    Rails.logger.debug("done")
    Rails.logger.debug("Going to run Judge module")
    save_data_from_judge params
    head :ok
  end

  def receive_status
    update_status status_params
  end

  private

  def check_trusted_ip
    unless Setting.trusted_ips.include? request.remote_ip
      head :forbidden
    end
  end

  def status_params
    params.permit :challenge_id, :step, :stage
  end

  def rec_params
    params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end