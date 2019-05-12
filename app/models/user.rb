class User < ApplicationRecord
  has_secure_password
  has_many :submissions, dependent: :destroy
  validates :username, presence: true, uniqueness: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  validates :surname, presence: true, allow_blank: false
end
