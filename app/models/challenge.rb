class MyChallengeValidator < ActiveModel::Validator
  def validate(challenge)
    if challenge.tournament.nil? and not challenge.user.nil?
      permitted = challenge.user.get_av_submissions.pluck(:id)
      unless permitted.include? challenge.sub1
        challenge.errors[:sub1] << 'Submission 1 is not permitted'
      end
      unless permitted.include? challenge.sub2
        challenge.errors[:sub2] << 'Submission 2 is not permitted'
      end
    end
  end
end

class Challenge < ApplicationRecord
  include Judge
  include ActiveModel::Validations
  default_scope { order(id: :desc) }
  belongs_to :tournament, optional: true
  belongs_to :user, optional: true
  belongs_to :submission, optional: true
  serialize :log
  serialize :state_par
  validates_with MyChallengeValidator

  after_create :init
  after_create :rejudge

  def init
    self.status = "Waiting"
    self.player_1_verdict = "N/A"
    self.player_2_verdict = "N/A"
    self.player1_id = Submission.find(self.sub1).user.id
    self.player2_id = Submission.find(self.sub2).user.id
  end

  def rejudge
    submission1 = Submission.find(self.sub1)
    submission2 = Submission.find(self.sub2)
    send_param = {
        challenge_id: self.id,
        lang: [submission1[:compiler], submission2[:compiler]],
        source: [submission1[:code], submission2[:code]],
        game: "tron",
        timeout: 0.2,
        state_par: {
            level: self.state_par[:level]
        }
    }
    send_data_to_judge send_param
  end

  def get_status
    if self.status == 'Running'
      redis = Redis.new
      return "Выполняется ход #{redis.get("challenge_status:#{self.id}").to_i}"
    end
    if self.status == 'Finished'
      return 'Протестировано'
    end
    if self.status == 'Preparing'
      return 'Подготовка'
    end
    if self.status == 'Waiting'
      return 'В очереди'
    end
  end

  def get_time_elapsed
    beg = self.started_testing_at
    endng = self.tested_time
    if beg.nil? or endng.nil?
      return "N/A"
    end
    seconds = (endng - beg).to_i
    "#{seconds / 60}:#{(seconds % 60).to_s.rjust(2, '0')}"
  end
end
