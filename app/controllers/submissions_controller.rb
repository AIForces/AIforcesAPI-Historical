class SubmissionsController < ApplicationController
  def index
  end

  def create
    if current_user == nil
      redirect_to sessions_new_url
    else
      @submission = current_user.submissions.create(submission_params)
      if @submission.save
        redirect_to submissions_index_url
      end
    end
  end

  def new
  end

  def show
  end

  private
    def submission_params
      params.require(:submission).permit(:compiler, :code)
    end
end
