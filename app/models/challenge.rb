class MyChallengeValidator < ActiveModel::Validator
  def validate(challenge)
    if challenge.tournament.nil? and not challenge.user.nil?
      permitted = challenge.user.get_av_submissions.pluck(:id)
      unless permitted.include? challenge.sub1
        record.errors[:sub1] << 'Submission 1 is not permitted'
      end
      unless permitted.include? challenge.sub2
        record.errors[:sub2] << 'Submission 2 is not permitted'
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
    self.status = "Running"
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
end
