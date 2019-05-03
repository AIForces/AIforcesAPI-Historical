class ChallengeController < ApplicationController
  def new
  end

  def create
    if current_user == nil
      redirect_to sessions_new_url
    else
      par = challenge_params
      par[:sub1] = User.find_by_username(par[:sub1])[:fav_id]
      par[:sub2] = User.find_by_username(par[:sub2])[:fav_id]
      Rails.logger.debug("My object: #{par.inspect}")
      @challenge = Challenge.create(par)
      @challenge[:status] = 'PT'
      if @challenge.save
        redirect_to challenge_index_url
      end
    end
  end

  def log

  end

  def visualize

  end

  def index
  end

  private

  def challenge_params
    params.require(:challenge).permit(:sub1, :sub2)
  end
end
