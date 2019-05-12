require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Judge

  def receive_data
    if Setting.trusted_ips.include? request.remote_ip
      save_data_from_judge rec_params
    else
      head :forbidden
    end
  end

  private

  def rec_params
    params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end