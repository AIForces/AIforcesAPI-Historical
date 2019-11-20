class TournamentController < ApplicationController
  before_action :set_tournament, only: [:show]
  before_action :check_logged_in
  before_action :set_tournaments, only: [:index]
  include ChallengeHelper

  def index
    render json: (@tournaments.map { |x|
      {
        id: x.id,
        name: x.name,
        status: x.get_status,
        start_at: (x.created_at.to_formatted_s :long)
      }
    })
  end

  def show
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
