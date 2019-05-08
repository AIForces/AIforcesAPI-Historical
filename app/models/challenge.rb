class Challenge < ApplicationRecord
  include Judge
  default_scope { order(id: :desc) }
  belongs_to :tournament, optional: true

  after_create :fill_default_vals
  after_create :send_challenge

  def fill_default_vals
    self.status = "Running"
    self.player_1_verdict = "N/A"
    self.player_2_verdict = "N/A"
    self.player1_id = Submission.find(self.sub1).user.id
    self.player2_id = Submission.find(self.sub2).user.id
  end

  def send_challenge
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
