require 'json'
class ChallengeController < ApplicationController
  include Judge
  before_action :set_challenge, only: [:log, :visualize]
  before_action :check_challenge, only: [:log, :visualize]
  before_action :check_logged_in

  def new
  end

  def create
    par = challenge_params
    submission1 = Submission.find_by_name(par[:sub1])
    submission2 = Submission.find_by_name(par[:sub2])

    @challenge = current_user.challenges.create(sub1: submission1.id, sub2: submission2.id, state_par: {
        level: par[:level].to_i
    })
    @challenge.save
    redirect_to challenge_index_url
  end

  def log
    my_log = Challenge.find_by_id(params[:id])[:log]
    respond_to do |format|
      format.html { (send_data my_log.to_json, filename: "Challenge #{@challenge.id} log.json", type: "application/json") }
      format.json { render json: my_log }
    end
  end

  def get_info
    @id = params[:id]
    x = Challenge.find(@id)
    @response = {
        id: x.id,
        player1: Submission.find(x.sub1).name,
        player2: Submission.find(x.sub2).name,
        player1_verdict: x.player_1_verdict,
        player2_verdict: x.player_2_verdict,
    }
    if x.winner.nil?
      if x.is_draw
        @response[:winner] = 'Ничья'
      else
        @response[:winner] = 'N/A'
      end
    else
      @response[:winner] = Submission.find(x.winner).name
    end
    render json: @response
  end

  def visualize
    # @visualizer_html = File.read("storage/games/#{current_event.game.name}/#{current_event.game.visualizer_file}")
    @visualizer_html = File.read("storage/games/tron/visualizer.html")
  end

  def index
    challenges = Challenge.where(tournament: nil, user_id: current_user.id)
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
          level: x.state_par[:level]
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
      cur_item
    }
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def check_challenge
      unless @challenge.tournament.nil?
        if current_user.role != 'admin' and not Setting.tournament_logs_open
          head :forbidden
        end
      end
    end

    def challenge_params
      params.require(:challenge).permit(:sub1, :sub2, :level)
    end
end
