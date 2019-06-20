module ChallengeHelper
  def get_info_ch (data)
    x = data[:challenge]
    keys = data[:keys]
    cur_item = {
        id: x.id,
        player1: Submission.find(x.sub1).get_info,
        player2: Submission.find(x.sub2).get_info,
        player1_verdict: x.player_1_verdict,
        player2_verdict: x.player_2_verdict,
        status: x.get_status,
        created_at: x.created_at.to_formatted_s(:short),
        level: x.state_par[:level],
        creator: 'N/A',
        time_elapsed: 'N/A'
    }
    if x.winner.nil?
      if x.is_draw
        cur_item[:winner] = 'Ничья'
      else
        cur_item[:winner] = 'N/A'
      end
    else
      cur_item[:winner] = Submission.find(x.winner).get_info
    end

    unless x.user.nil?
      cur_item[:creator] = x.user.username
    end
    unless x.tournament.nil?
      cur_item[:creator] = "Tournament #{x.tournament.id}"
    end

    if x.status == 'Finished'
      cur_item[:time_elapsed] = x.get_time_elapsed
    end

    unless keys.nil?
      return cur_item.slice(*keys.map {|s| s.parameterize.underscore.to_sym})
    end
    cur_item
  end

  def get_data_for_index (challenges, keys)
    @challenges_data = (challenges.map { |x| get_info_ch ({
        challenge: x,
        keys: keys
    })})
  end
end
