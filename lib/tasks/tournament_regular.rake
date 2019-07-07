namespace :tournament_regular do
  desc "TODO"
  task morning: :environment do
    x = Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Утренний турнир #{Time.now.in_time_zone.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1, event: Event.find(Setting.default_event)
    x.save
  end

  desc "TODO"
  task afternoon: :environment do
    x = Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Дневной турнир #{Time.now.in_time_zone.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1,
                      event: Event.find(Setting.default_event)
    x.save
  end

  desc "TODO"
  task evening: :environment do
    x = Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Вечерний турнир #{Time.now.in_time_zone.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1,
                      event: Event.find(Setting.default_event)
    x.save
  end

  desc "TODO"
  task night: :environment do
      x = Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                        name: "Ночной турнир #{Time.now.in_time_zone.to_formatted_s(:long)}",
                        number_of_ch_per_pair: 1,
                        event: Event.find(Setting.default_event)
      x.save
  end

end
