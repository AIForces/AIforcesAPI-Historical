module ChallengeHelper

  def get_data_for_index (challenges)
    @challenges_data = challenges.map { |x|
      cur_item = {
          id: x.id,
          player1: Submission.find(x.sub1).name,
          player2: Submission.find(x.sub2).name,
          player1_verdict: x.player_1_verdict,
          player2_verdict: x.player_2_verdict,
          status: x.get_status,
          time_elapsed: x.get_time_elapsed,
          created_at: x.created_at.to_formatted_s(:short),
          level: x.state_par[:level],
          creator: 'N/A'
      }
      if x.winner.nil?
        if x.is_draw
          cur_item[:winner] = 'Ничья'
        else
          cur_item[:winner] = 'N/A'
        end
      else
        cur_item[:winner] = Submission.find(x.winner).name
      end

      unless x.user.nil?
        cur_item[:creator] = x.user.username
      end
      unless x.tournament.nil?
        cur_item[:creator] = "Tournament #{x.tournament.id}"
      end

      cur_item
    }
  end
end
