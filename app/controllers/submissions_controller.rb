class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:source]
  before_action :check_logged_in

  def create
    @submission = current_user.submissions.create(submission_params)
    if @submission.save
      redirect_to submissions_index_url
    end
  end

  def index
    @submissions_data = current_user.submissions.map {|x|
      cur_item = {
          id: x.id,
          used_for_ch: x.used_for_ch,
          used_for_tours: x.used_for_tours,
          lang: x.compiler
      }
      if x.challenge.nil?
        cur_item[:status] = 'Нет проверки'
        cur_item[:verdict] = 'Недоступно'
      else
        cur_item[:status] = x.challenge.status
        cur_item[:verdict] = x.challenge.player_1_verdict
      end
      cur_item[:created_at] = x.created_at.to_formatted_s(:short)
      cur_item
    }
  end

  def new
  end

  def show
  end

  def make_used_for_ch
    new_fav_id = params[:id]
    unless current_user.fav_ch_id.nil?
      last_subm = Submission.find_by_id current_user.fav_ch_id
      last_subm.used_for_ch = nil
      last_subm.save
    end
    current_user.update!(fav_ch_id: new_fav_id)
    cur_subm = Submission.find_by_id(params[:id])
    cur_subm.used_for_ch = true
    cur_subm.save
  end

  def make_used_for_tours
    new_fav_id = params[:id]
    unless current_user.fav_tours_id.nil?
      last_subm = Submission.find_by_id current_user.fav_tours_id
      last_subm.used_for_tours = nil
      last_subm.save
    end
    current_user.update(fav_tours_id: new_fav_id)
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
