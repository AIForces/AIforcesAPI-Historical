class Event < ApplicationRecord
  after_create :init
  def init
    self.rules_file = 'rules.html'
  end

  def load_config (config)
  end
end
