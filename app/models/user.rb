class User < ApplicationRecord
  has_secure_password
  has_many :submissions, dependent: :destroy
  has_many :challenges, dependent: :destroy
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  validates :surname, presence: true, allow_blank: false

  after_create :init

  def init
    self.role = 'user'
  end

  def get_av_submissions
    Submission.where(["used_for_ch = true or user_id = ?", self.id])
  end
end
