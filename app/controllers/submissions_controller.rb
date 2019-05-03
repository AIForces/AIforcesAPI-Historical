class SubmissionsController < ApplicationController
  def index
  end

  def create
    if current_user == nil
      redirect_to sessions_new_url
    else
      @submission = current_user.submissions.create(submission_params)
      @submission[:status] = 'PT'
      if @submission.save
        redirect_to submissions_index_url
      end
    end
  end

  def new
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  def show
    if current_user == nil
      redirect_to sessions_new_url
    end
  end

  def makefav
    new_fav_id = params[:fav_id]
    current_user[:fav_id] = new_fav_id
    current_user.save
    redirect_to submissions_index_url
  end

  private
    def submission_params
      params.require(:submission).permit(:compiler, :code)
    end
end
