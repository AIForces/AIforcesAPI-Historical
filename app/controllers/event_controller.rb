class EventController < ApplicationController
  def index
  end

  def rules
    @rules_html = File.read("storage/events/#{current_event.name}/#{current_event.rules_file}")
  end
end
