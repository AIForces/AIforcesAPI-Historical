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
    @challenge = current_user.challenges.create(sub1: submission1.id, sub2: submission2.id)
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

  def visualize
    @id = params[:id]
    x = Challenge.find(@id)
    @cur_item = {
        id: x.id,
        player1: Submission.find(x.sub1).name,
        player2: Submission.find(x.sub2).name,
        player1_verdict: x.player_1_verdict,
        player2_verdict: x.player_2_verdict,
    }
    if x.winner.nil?
      if x.is_draw
        @cur_item[:winner] = 'Ничья'
      else
        @cur_item[:winner] = 'N/A'
      end
    else
      @cur_item[:winner] = Submission.find(x.winner).name
    end
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

      if x.status == 'Running'
        cur_item[:status] = 'Тестируется'
      else
        cur_item[:status] = 'Протестировано'
      end
      cur_item
    }
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def check_logged_in
      if current_user == nil
        redirect_to sessions_new_url
      end
    end

    def check_challenge
      unless @challenge.tournament.nil?
        head :forbidden
      end
    end

    def challenge_params
      params.require(:challenge).permit(:sub1, :sub2)
    end
end
