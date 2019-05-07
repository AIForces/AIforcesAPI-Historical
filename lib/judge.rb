module Judge

  def save_data_from_judge (par)
    cur_challenge = Challenge.find_by_id(par[:challenge_id])
    cur_challenge.status = 'Finished'
    cur_challenge.log = par[:log]
    cur_challenge.player_1_verdict = par[:player1_verdict]
    cur_challenge.player_2_verdict = par[:player2_verdict]
    cur_challenge.winner = par[:winner]
    cur_challenge.save
  end

  def send_data_to_judge (send_params)
    endpoint = 'http://127.0.0.1:3001/judge'
    uri = URI(endpoint)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = send_params.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    Rails.logger.debug("Result of save: #{res.inspect}")
  end
end