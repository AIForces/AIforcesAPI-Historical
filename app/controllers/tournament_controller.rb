class TournamentController < ApplicationController
  before_action :set_tournament, only: [:show]
  before_action :check_logged_in
  include ChallengeHelper

  def index
  end

  def show
    @challenges_data = get_data_for_index @tournament.challenges, nil
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

  def index_spa
    render json: (Tournament.all.map { |x|
      {
        id: x.id,
        name: x.name,
        status: x.get_status,
        start_at: (x.created_at.to_formatted_s :long)
      }
    })
  end

  def show_spa
    render json: ([Tournament.find(params[:id])].map { |x|
      {
          id: x.id,
          name: x.name,
          status: x.get_status,
          start_at: (x.created_at.to_formatted_s :long),
          data: x.get_complete_data
      }
    }[0])
  end

  private

  def tournament_params
    params.permit(:name, :number_of_ch_per_pair)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
