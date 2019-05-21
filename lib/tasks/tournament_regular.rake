namespace :tournament_regular do
  desc "TODO"
  task morning: :environment do
    Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Утренний турнир #{Time.now.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1
  end

  desc "TODO"
  task afternoon: :environment do
    Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Дневной турнир #{Time.now.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1
  end

  desc "TODO"
  task evening: :environment do
    Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Вечерний турнир #{Time.now.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1
  end

  desc "TODO"
  task night: :environment do
    Tournament.create participants: User.where.not(fav_tours_id: nil).map {|x| x.id},
                      name: "Ночной турнир #{Time.now.to_formatted_s(:long)}",
                      number_of_ch_per_pair: 1
  end

end
