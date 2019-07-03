class SubmissionsController < ApplicationController
  before_action :check_logged_in
  before_action :set_submission, only: [:source, :source_spa, :show_spa]
  before_action :check_submission_id, only: [:source]
  before_action :check_admin, only: [:manage, :destroy]
  include SubmissionsHelper


  def create
    @submission = current_user.submissions.create(submission_params)
    if @submission.save
      redirect_to submissions_index_url
    end
  end

  def create_spa
    @submission = current_user.submissions.create(submission_params)
    if @submission.save
      head :ok
    else
      render json: { errors: @submission.errors.full_messages }, status: :bad_request
    end
  end

  def index
  end

  def new
  end

  def show
  end

  def make_used_for_tours
    new_fav_id = params[:id]
    unless current_user.fav_tours_id.nil?
      last_subm = Submission.find_by_id current_user.fav_tours_id
      last_subm.used_for_tours = false
      last_subm.save
    end
    current_user.update(fav_tours_id: new_fav_id)
    cur_subm = Submission.find_by_id(params[:id])
    cur_subm.used_for_tours = true
    cur_subm.save
    head :ok
  end

  def source
    @needed_id = params[:id]
  end

  def manage
  end

  def destroy
    Submission.find(params[:id]).destroy
    redirect_to submissions_manage_url
  end

  def make_opened
    x = current_user.submissions.find(params[:id])
    x.opened = true
    x.save
    head :ok
  end

  def index_spa
    render json: (current_user.submissions.map { |x|
      get_info ({
          submission: x,
          keys: params[:keys]
      })})
  end

  def show_spa
    render json: (get_info ({
      submission: @submission,
      keys: params[:keys]
    }))
  end

  def public
    render json: { ids: User.find(params[:id]).submissions.where(opened: true).pluck(:id) }
  end

  private
    def submission_params
      params.require(:submission).permit(:name, :compiler, :code)
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def check_submission_id
      unless Submission.exists? id: params[:id]
        head 404
      end
      unless is_admin?
        unless current_user.submissions.exists? id: params[:id]
          head :forbidden
        end
      end
    end
end
