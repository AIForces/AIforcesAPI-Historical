class Submission < ApplicationRecord
  default_scope { order(id: :desc) }
  belongs_to :user
  has_one :challenge
  validates :compiler, acceptance: { accept: ["Python 3.7", "GNU C++ 17", "Java"]}
  after_create :init

  def init
    self.used_for_tours = 0
    self.used_for_ch = 0
    self.opened = false
    self.won = 0
    self.lost = 0
    self.drawn = 0

    unless Setting.judges_submission.nil?
      self.challenge = Challenge.create(sub1: self.id, sub2: Setting.judges_submission, state_par: {
        level: 1
      })
      self.challenge.save
    end
  end

  def recalculate_stats

  end

  def get_info
    "#{self.user.username}. ID: #{self.id}. #{self.name}"
  end

end
