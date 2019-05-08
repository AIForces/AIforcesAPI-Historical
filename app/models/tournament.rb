class Tournament < ApplicationRecord
  has_many :challenges
  serialize :participants
  after_save :add_to_queue

  def get_person_points player
    all_games = self.challenges.where("player1_id = #{player} OR player2_id = #{player}")
    win = all_games.where(winner_id: player).count
    draw = all_games.where(is_draw: true).count
    Rails.logger.debug("cnt #{win} #{draw}")
    2 * win + draw
  end

  def get_rating
    resp = {}
    self.participants.each {|x| resp[x] = get_person_points x}
    resp.sort_by { |id, rating| rating}.reverse
  end

  def get_info_for_table (player1, player2)
    all_games = self.challenges.where(player1_id: player1, player2_id: player2)
    w1 = all_games.where(winner_id: player1).count
    draw = all_games.where(is_draw: true).count
    w2 = all_games.where(winner_id: player2).count
    [w1, draw, w2]
  end

  def add_to_queue
    # WTF is that?
    Rails.logger.debug("add to q")
    if self.challenges.empty?
      self.participants.each do |player1_id|
        self.participants.each do |player2_id|
          if player1_id != player2_id
            player1 = User.find(player1_id)
            player2 = User.find(player2_id)
            Rails.logger.debug("adding to chals #{player1_id}, #{player2_id}")
            self.number_of_ch_per_pair.times do
                next_chal = self.challenges.create(sub1: player1.fav_tours_id, sub2: player2.fav_tours_id)
                next_chal.save
            end
          end
        end
      end
    end
  end
end
