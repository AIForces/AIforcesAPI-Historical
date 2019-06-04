require 'git'
namespace :get_example do
  task game: :environment do
    Git.clone('https://github.com/aalekseevx/tron.git', 'storage/games/tron_temp')
    FileUtils.mv('storage/games/tron_temp', 'storage/games/tron')
    FileUtils.rm_rf('storage/games/tron_temp')
  end

  task event: :environment do
    Git.clone('https://github.com/aalekseevx/tron_event.git', 'storage/games/tron_event_temp')
    FileUtils.mv('storage/games/tron_event_temp', 'storage/events/tron_event')
    FileUtils.rm_rf('storage/games/tron_event_temp')
  end

  task import: :environment do
    Rake::Task["import_data:game"].invoke("tron")
    Rake::Task["import_data:event"].invoke("tron_event")
    Setting.default_event = Event.last.id
  end
end
