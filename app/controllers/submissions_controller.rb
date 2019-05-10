class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:source]

  def index
  end

  def create
    if current_user == nil
      redirect_to sessions_new_url
    else
      @submission = current_user.submissions.create(submission_params)
      @submission[:status] = 'Running'
      @submission[:name] = "#{@submission.user.username}. ID:#{@submission.id}"
      if @submission.save
        redirect_to submissions_index_url
      end
    end
  end

  def index
    if current_user == nil
      redirect_to sessions_new_url
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

  def make_used_for_ch
    new_fav_id = params[:id]
    if not current_user.fav_ch_id.nil?
      last_subm = Submission.find_by_id current_user.fav_ch_id
      last_subm.used_for_ch = nil
      last_subm.save
    end
    current_user.fav_ch_id = new_fav_id
    current_user.save
    cur_subm = Submission.find_by_id(params[:id])
    cur_subm.used_for_ch = true
    cur_subm.save
  end

  def make_used_for_tours
    new_fav_id = params[:id]
    if not current_user.fav_tours_id.nil?
      last_subm = Submission.find_by_id current_user.fav_tours_id
      last_subm.used_for_tours = nil
      last_subm.save
    end
    current_user.fav_tours_id = new_fav_id
    current_user.save
    cur_subm = Submission.find_by_id(params[:id])
    cur_subm.used_for_tours = true
    cur_subm.save
  end

  def source
    @needed_id = params[:id]
  end

  private
    def submission_params
      params.require(:submission).permit(:compiler, :code)
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end
end
