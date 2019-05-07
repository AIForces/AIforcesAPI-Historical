class ChallengeController < ApplicationController
  include Judge
  before_action :set_challenge, only: [:log, :visualize]
  before_action :check_challenge, only: [:log, :visualize]

  def new
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  def create
    if current_user == nil
      redirect_to sessions_new_url
    else
      par = challenge_params
      submission1 = Submission.find_by_name(par[:sub1])
      submission2 = Submission.find_by_name(par[:sub2])
      @challenge = Challenge.create(sub1: submission1.id, sub2: submission2.id)
      @challenge.save
      redirect_to challenge_index_url
    end
  end

  def log
    @my_log = Challenge.find_by_id(params[:id])[:log]
  end

  def visualize

  end

  def index
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
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
