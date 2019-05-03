class User < ApplicationRecord
  has_secure_password
  has_many :submissions, dependent: :destroy
  validates :username, presence: true, uniqueness: true
end
