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
    html = File.read("storage/events/#{current_event.name}/#{current_event.rules_file}")
    render json: {
        html: html,
        js: ""
    }
  end

  def statements_spa
    g = current_event.game
    html = File.read("storage/games/#{g.name}/#{g.statement_file}")
    css = File.read("storage/games/#{g.name}/statement.css")
    js = File.read("storage/games/#{g.name}/statement.js")
    render json: {
        html: "#{html}<style>#{css}</style>",
        js: js
    }
  end

  def visualizer_spa
    vis_html = File.read("storage/games/tron/visualizer/visualizer.html")
    vis_css = File.read("storage/games/tron/visualizer/visualizer.css")
    vis_js = File.read("storage/games/tron/visualizer/visualizer.js")

    render json: {
        html: "#{vis_html}<style>#{vis_css}</style>",
        js: vis_js
    }
  end

  def participants
    render json: { ids: User.all.map { |x|
        {
          id: x.id,
          username: x.username,
          name: x.name,
          surname: x.surname
        }
      }
    }
  end
end
