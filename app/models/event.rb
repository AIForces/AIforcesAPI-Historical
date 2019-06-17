class Event < ApplicationRecord
  after_create :init
  belongs_to :game
  has_many :tournaments

  def init
    self.rules_file = 'rules.html'
    self.save
  end

  def load_config (config)
    self.name = config['name']
    # TODO: add validation: name is unique
    self.game = Game.find_by_name(config['game'])
    self.save
  end
end
