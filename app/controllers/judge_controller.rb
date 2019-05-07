require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Judge

  def receive_data
    trusted_ip = '127.0.0.1'
    if request.remote_ip != trusted_ip
      head :forbidden
    end
    save_data_from_judge rec_params
  end

  private

  def rec_params
      params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end
end