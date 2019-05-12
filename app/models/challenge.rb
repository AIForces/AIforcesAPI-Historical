class MyChallengeValidator < ActiveModel::Validator
  def validate(challenge)
    permitted = challenge.user.get_av_submissions.pluck(:id)
    unless permitted.include? challenge.sub1
      record.errors[:sub1] << 'Submission 1 is not permitted'
    end
    unless permitted.include? challenge.sub2
      record.errors[:sub2] << 'Submission 2 is not permitted'
    end
  end
end

class Challenge < ApplicationRecord
  include Judge
  include ActiveModel::Validations
  default_scope { order(id: :desc) }
  belongs_to :tournament, optional: true
  belongs_to :user, optional: true
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
        lang1: submission1[:compiler],
        lang2: submission2[:compiler],
        source1: submission1[:code],
        source2: submission2[:code]
    }
    send_data_to_judge send_param
  end
end
