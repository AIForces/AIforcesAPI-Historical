require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  force_ssl except: [:receive_data]
  include Judge

  def receive_data
    # Not safe, but so good!
    Rails.logger.debug("Permitting parameters")
    params.permit!
    Rails.logger.debug("done")
    if Setting.trusted_ips.include? request.remote_ip
      Rails.logger.debug("Going to run Judge module")
      save_data_from_judge params
      head :ok
    else
      Rails.logger.debug("Banned ip")
      head :forbidden
    end
  end

  private

  def rec_params
    params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end