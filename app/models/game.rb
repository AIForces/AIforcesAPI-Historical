class Game < ApplicationRecord
  after_create :init
  has_many :events
  def init
    self.statement_file = 'statement.html'
    self.visualizer_file = 'visualizer.html'
    self.checker_file = 'checker.py'
    self.solution_file = 'solutions/solution.cpp'
    self.save
  end

  def load_config (config)
    self.name = config['name']
    self.timeout = config['timeout']
    self.memory_limit = config['memory_limit']
    self.save
  end
end
