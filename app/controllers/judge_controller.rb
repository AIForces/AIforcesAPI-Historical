require 'net/http'
require 'json'

class JudgeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def receive_data
    trusted_ip = '127.0.0.1'
    if request.remote_ip != trusted_ip
      head :forbidden
    end
    par = rec_params
    cur_challenge = Challenge.find_by_id(par[:challenge_id])
    cur_challenge.status = 'Finished'
    cur_challenge.log = par[:log]
    cur_challenge.player_1_verdict = par[:player1_verdict]
    cur_challenge.player_2_verdict = par[:player2_verdict]
    cur_challenge.winner = par[:winner]

    cur_challenge.save
  end

  def send_data
    endpoint = 'http://127.0.0.1:3001/judge'
    uri = URI(endpoint)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = send_params.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    Rails.logger.debug("Result of save: #{res.inspect}")
    redirect_to challenge_index_url
  end

  private

  def rec_params
      params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
  end

  def send_params
    params.permit :challenge_id, :lang1, :source1, :lang2, :source2
  end
end