require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Judge

  def receive_data
    unless Setting.judges_endpoints.include? request.remote_ip
      head :forbidden
    end
    save_data_from_judge rec_params
  end

  private

  def rec_params
    params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end