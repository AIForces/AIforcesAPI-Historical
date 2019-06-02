namespace :import_data do

  task :game, [:name] => [:environment] do |task, args|
    config = File.open "storage/games/#{args[:name]}/config.json"
    game = Game.new
    game.load_config (JSON.load config)
    game.save
  end

  task :event, [:name] do |task, args|
    config = File.open "storage/events/#{args[:name]}/config.json"
    event = Event.create
    event.load_config (JSON.load config)
  end
end
