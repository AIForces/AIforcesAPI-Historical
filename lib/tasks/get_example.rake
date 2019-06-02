require 'git'
namespace :get_example do
  task game: :environment do
    Git.clone('https://github.com/aalekseevx/tron.git', 'storage/games/tron')
  end

  task event: :environment do
   Git.clone('https://github.com/aalekseevx/tron_event.git', 'storage/events/tron_event')
  end

  task import: :environment do
    Rake::Task["import_data:game"].invoke("tron")
    Rake::Task["import_data:event"].invoke("tron_event")
    Setting.default_event = Event.last.id
  end
end
