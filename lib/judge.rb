# require "redis"
module Judge

  def save_data_from_judge (par)
    Rails.logger.debug("at Saving data from judge...")
    cur_challenge = Challenge.find_by_id(par[:challenge_id])
    cur_challenge.status = 'Finished'
    cur_challenge.log = par[:log]
    cur_challenge.player_1_verdict = par[:verdicts][0]
    cur_challenge.player_2_verdict = par[:verdicts][1]
    cur_challenge.tested_time = DateTime.now
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

  def update_status param
    redis = Redis.new
    redis.set("challenge_status:#{param[:challenge_id]}", param[:step])
    if param[:stage] == 'Running' and param[:step] == 0
      cur_challenge = Challenge.find(param[:challenge_id])
      cur_challenge.status = 'Running'
      cur_challenge.save
    end

    if param[:stage] == 'Preparing'
      cur_challenge = Challenge.find(param[:challenge_id])
      cur_challenge.started_testing_at = DateTime.now
      cur_challenge.status = 'Preparing'
      cur_challenge.save
    end
  end
end