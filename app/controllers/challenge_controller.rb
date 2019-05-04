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
      @challenge = Challenge.create(par)
      @challenge[:status] = 'Running'
      @challenge.player_1_verdict = 'N/A'
      @challenge.player_2_verdict = 'N/A'
      if @challenge.save
        submission1 = Submission.find_by_id(par[:sub1])
        submission2 = Submission.find_by_id(par[:sub2])
        send_param = {
            challenge_id: @challenge[:id],
            lang1: submission1[:compiler],
            lang2: submission2[:compiler],
            source1: submission1[:code],
            source2: submission2[:code]
        }
        redirect_to judge_send_data_url(send_param)
      end
    end
  end

  def log
    @my_log = Challenge.find_by_id(params[:id])[:log]
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
