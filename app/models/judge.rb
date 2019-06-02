class Judge < ApplicationRecord
  after_create :reconfigure

  def get_judge_endpoint
    "http:/#{self.ip}/judge"
  end

  def configure_for (game)

  end

  def reconfigure

  end
end
