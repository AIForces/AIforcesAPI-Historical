class Submission < ApplicationRecord
  default_scope { order(id: :desc) }
  belongs_to :user
  validates :compiler, acceptance: { accept: ["Python 3.7", "GNU C++ 17", "Java"]}
  after_create :init

  def init
    self.status = 'Running'
    self.name = "#{self.user.username}. ID:#{self.id}"
    self.used_for_tours = 0
    self.used_for_ch = 0
  end
end
