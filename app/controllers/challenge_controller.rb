require 'json'
require 'redis'
class ChallengeController < ApplicationController
  include Judge
  include ChallengeHelper
  before_action :set_challenge, only: [:log, :visualize, :get_streams, :show_spa]
  before_action :check_challenge, only: [:log, :visualize, :show_spa]
  before_action :check_logged_in, except: [:receive_data, :update_status]
  before_action :check_admin, only: [:manage, :rejudge]
  # skip_before_action :verify_authenticity_token, only: [:receive_data, :update_status]
  before_action :check_trusted_ip, only: [:receive_data, :update_status]
  # force_ssl except: [:receive_data, :update_status]

  def new
  end

  def create
    par = challenge_params
    @challenge = current_user.challenges.create(sub1: par[:sub1].to_i, sub2: par[:sub2].to_i, state_par: {
        level: par[:level].to_i
    })

    @challenge.save
    redirect_to challenge_index_url
  end

  def create_spa
    par = challenge_params
    @challenge = current_user.challenges.create(sub1: par[:sub1].to_i, sub2: par[:sub2].to_i, state_par: {
        level: par[:level].to_i
    })

    if @challenge.save
      head :ok
    else
      render json: { errors: @challenge.errors.full_messages}, status: :bad_request
    end
  end

  def manage
    @challenges_data = get_data_for_index Challenge.where(tournament_id: nil), nil
  end

  def log
    my_log = Challenge.find_by_id(params[:id])[:log]
    respond_to do |format|
      format.html { (send_data my_log.to_json, filename: "Challenge #{@challenge.id} log.json", type: "application/json") }
      format.json { render json: my_log }
    end
  end

  def get_info
    @id = params[:id]
    x = Challenge.find(@id)
    @response = {
        id: x.id,
        player1: Submission.find(x.sub1).name,
        player2: Submission.find(x.sub2).name,
        player1_verdict: x.player_1_verdict,
        player2_verdict: x.player_2_verdict,
    }
    if x.winner.nil?
      if x.is_draw
        @response[:winner] = 'Ничья'
      else
        @response[:winner] = 'N/A'
      end
    else
      @response[:winner] = Submission.find(x.winner).name
    end
    render json: @response
  end

  def get_streams
    streams =  @challenge.streams.slice *params[:streams]
    streams = streams.to_h.map { |stream, data|
      [stream, data.slice(*params[:players])]
    }.to_h
    if Submission.find(@challenge.sub1).user != current_user and params[:streams].include? 'stderr' and not streams['stderr']['0'].nil?
      streams['stderr']['0'] = ['[ Нет доступа ]'] * streams['stderr']['0'].length
      end
    if Submission.find(@challenge.sub2).user != current_user and params[:streams].include? 'stderr' and not streams['stderr']['1'].nil?
      streams['stderr']['1'] = ['[ Нет доступа ]'] * streams['stderr']['1'].length
    end

    render json: streams

  end

  def visualize
    # @visualizer_html = File.read("storage/games/#{current_event.game.name}/#{current_event.game.visualizer_file}")
    @visualizer_html = File.read("storage/games/tron/visualizer/visualizer.html")
    @visualizer_css = File.read("storage/games/tron/visualizer/visualizer.css")
    @visualizer_js = File.read("storage/games/tron/visualizer/visualizer.js")
  end

  def index
    challenges = Challenge.where(tournament: nil, user_id: current_user.id)
    @challenges_data = get_data_for_index challenges, nil
  end

  def receive_data
    params.permit!
    save_data_from_judge params
    head :ok
  end

  def update_status
    update_status_j status_params
  end

  def rejudge
    Challenge.find(id_params[:id]).rejudge
    redirect_to challenge_manage_url
  end

  def destroy
    Challenge.find(id_params[:id]).destroy
    redirect_to challenge_manage_url
  end

  def index_spa
    render json: (get_data_for_index current_user.challenges, params[:keys])
  end

  def show_spa
    render json: (get_info_ch ({
        challenge: @challenge,
        keys: params[:keys]}))
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def check_challenge
      unless current_user.role == 'admin'
        unless @challenge.tournament.nil?
            unless Setting.tournament_logs_open
              head :forbidden
          end
        end

        unless challenge.user == current_user
          head :forbidden
        end
      end
    end

    def challenge_params
        params.require(:challenge).permit(:sub1, :sub2, :level)
    end

    def check_trusted_ip
      unless Setting.trusted_ips.include? request.remote_ip
        head :forbidden
      end
    end

    def status_params
      params.permit :challenge_id, :step, :stage
    end

    def rec_params
        params.permit :challenge_id, :player1_verdict, :player2_verdict, :winner, :log
    end

    def id_params
      params.permit :id
    end
end
