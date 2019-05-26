module Judge

  def save_data_from_judge (par)
    Rails.logger.debug("at Saving data from judge...")
    cur_challenge = Challenge.find_by_id(par[:challenge_id])
    cur_challenge.status = 'Finished'
    cur_challenge.log = par[:log]
    cur_challenge.player_1_verdict = par[:verdicts][0]
    cur_challenge.player_2_verdict = par[:verdicts][1]
    if par[:winner] == 0
      cur_challenge.winner = cur_challenge.sub1
      cur_challenge.winner_id = Submission.find(cur_challenge.sub1).user.id
    end
    if par[:winner] == 1
          cur_challenge.winner = cur_challenge.sub2
          cur_challenge.winner_id = Submission.find(cur_challenge.sub2).user.id
    end
    if par[:winner] == -1
      cur_challenge.is_draw = 1
    end
    Rails.logger.debug("going to save")
    cur_challenge.save
  end

  def send_data_to_judge (send_params)
    endpoint = Setting.judges_endpoints.sample
    uri = URI(endpoint)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = send_params.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end