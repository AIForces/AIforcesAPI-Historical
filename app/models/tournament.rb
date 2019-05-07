class Tournament < ApplicationRecord
  has_many :challenges
  serialize :participants
  after_save :add_to_queue

  def get_person_points player

  end

  def get_rating

  end

  

  def add_to_queue
    Rails.logger.debug(self.inspect)
    self.participants.each do |player1_id|
      self.participants.each do |player2_id|
        if player1_id != player2_id
          player1 = User.find(player1_id)
          player2 = User.find(player2_id)
          self.number_of_ch_per_pair.times do
              self.challenges.create(sub1: player1.fav_tours_id, sub2: player2.fav_tours_id)
          end
        end
      end
    end
  end
end
