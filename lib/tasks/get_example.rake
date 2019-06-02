require 'git'
namespace :get_example do
  task game: :environment do
    Git.clone('https://github.com/aalekseevx/TronPackage.git', 'storage/games/tron')
  end

  task event: :environment do
   Git.clone('https://github.com/aalekseevx/TronPackage.git', 'storage/events/tron_event')
  end

  task import: :environment do
    Rake::Task["import_data:game"].invoke("tron")
    Rake::Task["import_data:event"].invoke("tron_event")
  end
end
