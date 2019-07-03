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

  def rules_spa
    rules_html = File.read("storage/events/#{current_event.name}/#{current_event.rules_file}")
    render inline: rules_html, layout: false
  end

  def statements_spa
    g = current_event.game
    statements_html = File.read("storage/games/#{g.name}/#{g.statement_file}")
    render inline: statements_html, layout: false
  end

  def visualizer_spa
    vis_html = File.read("storage/games/tron/visualizer/visualizer.html")
    vis_css = File.read("storage/games/tron/visualizer/visualizer.css")
    vis_js = File.read("storage/games/tron/visualizer/visualizer.js")

    render inline: "#{vis_html}<style>#{vis_css}</style><script>#{vis_js}</script>"
  end

  def participants
    render json: { ids: User.all.pluck(:id)  }
  end
end
