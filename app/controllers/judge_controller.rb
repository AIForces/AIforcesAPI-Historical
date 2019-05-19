require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  force_ssl except: [:receive_data]
  include Judge

  def receive_data
    # Not safe, but so good!
    params.permit!
    if Setting.trusted_ips.include? request.remote_ip
      save_data_from_judge params
    else
      head :forbidden
    end
  end

  private

  def rec_params
    params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end