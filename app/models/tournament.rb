class Tournament < ApplicationRecord
  default_scope { order(id: :desc) }
  has_many :challenges
  serialize :participants
  after_save :add_to_queue
  belongs_to :event

  def get_person_points player
    all_games = self.challenges.where("player1_id = #{player} OR player2_id = #{player}")
    win = all_games.where(winner_id: player).count
    draw = all_games.where(is_draw: true).count
    2 * win + draw
  end

  def get_rating
    resp = {}
    self.participants.each {|x| resp[x] = get_person_points x}
    resp.sort_by { |id, rating| rating}.reverse
  end

  def get_status
    done_cnt = self.challenges.where(status: "Finished").count
    all_cnt = self.challenges.count
    if done_cnt < all_cnt
      status = 'Проводится'
    else
      status = 'Закончен'
    end
    "#{status}. #{done_cnt}/#{all_cnt}"
  end

  def get_info_for_table (player1, player2)
    w1 = self.challenges.where(player1_id: player1, player2_id: player2, winner_id: player1).count
    draw = self.challenges.where(player1_id: player1, player2_id: player2, is_draw: true).count
    w2 = self.challenges.where(player1_id: player1, player2_id: player2, winner_id: player2).count
    [w1, draw, w2]
  end

  def get_complete_data
    resp = {}
    self.participants.each do |player1_id|
      resp[player1_id] = {}
      self.participants.each do |player2_id|
        player1 = User.find(player1_id)
        player2 = User.find(player2_id)
        resp[player1_id][player2_id] = get_info_for_table player1, player2
      end
    end
    resp
  end
  def add_to_queue
    state_pars = [
        {
            level: 1
        },
        {
            level: 2
        },
        {
            level: 3
        },
        {
            level: 4
        },
        {
            level: 5
        },
        {
            level: 6
        },
        {
            level: 7
        },
        {
            level: 8
        },
        {
            level: 9
        },
        {
            level: 10
        },
    ]
    if self.challenges.empty?
      self.participants.each do |player1_id|
        self.participants.each do |player2_id|
          if player1_id != player2_id
            player1 = User.find(player1_id)
            player2 = User.find(player2_id)
            state_pars.each { |conf|
              self.number_of_ch_per_pair.times do
                  next_chal = self.challenges.create(sub1: player1.fav_tours_id, sub2: player2.fav_tours_id, state_par: conf)
                  next_chal.save
              end
            }
          end
        end
      end
    end
  end
end
