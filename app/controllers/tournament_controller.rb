class TournamentController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

  end

  def show

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
    Rails.logger.debug(par)
    @tournament = Tournament.create(par)
    if @tournament.save
      redirect_to tournament_index_url
    end
  end

  private

  def tournament_params
    params.permit(:name, :number_of_ch_per_pair)
  end
end
