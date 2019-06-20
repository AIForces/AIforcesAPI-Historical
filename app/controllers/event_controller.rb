class EventController < ApplicationController
  def index
  end

  def rules
    @rules_html = File.read("storage/events/#{current_event.name}/#{current_event.rules_file}")
  end

  def statements
    g = current_event.game
    @statement_html = File.read("storage/games/#{g.name}/#{g.statement_file}")
  end

end
