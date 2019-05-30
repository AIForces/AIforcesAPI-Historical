class TournamentController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_tournament, only: [:show]
  before_action :check_logged_in

  def index
  end

  def show
    # Same as in challenge controller. How to merge?
    challenges = @tournament.challenges
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

  def new
    if current_user == nil or current_user.role != 'admin'
      head :forbidden
    end
  end

  def create
    if current_user == nil or current_user.role != 'admin'
      head :forbidden
    end

    par = tournament_params
    par[:participants] = User.where.not(fav_tours_id: nil).map {|x| x.id}
    @tournament = Tournament.create(par)
    if @tournament.save
      redirect_to tournament_index_url
    end
  end

  private

  def tournament_params
    params.permit(:name, :number_of_ch_per_pair)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
