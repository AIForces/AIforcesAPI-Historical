class TournamentController < ApplicationController
  before_action :set_tournament, only: [:show, :show_spa]
  before_action :check_logged_in
  before_action :set_tournaments, only: [:index, :index_spa]
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
    render json: (@tournaments.map { |x|
      {
        id: x.id,
        name: x.name,
        status: x.get_status,
        start_at: (x.created_at.to_formatted_s :long)
      }
    })
  end

  def show_spa
    render json: ([@tournament].map { |x|
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
    if @tournament.hidden and not is_admin?
      head :forbidden
    end
  end

  def set_tournaments
      if is_admin?
        @tournaments = Tournament.all
      else
        @tournaments = Tournament.where(hidden: false)
      end
  end
end
