class ChallengeController < ApplicationController
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
      @challenge = Challenge.create(sub1: submission1.id, sub2: submission2.id, status: "Running", player_1_verdict: "N/A", player_2_verdict: "N/A")
      if @challenge.save
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
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:sub1, :sub2)
  end
end
