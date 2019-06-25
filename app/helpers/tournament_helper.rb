module TournamentHelper
  def get_tour_data_for_table_tr (tournaments)
    tournaments.map {|x|
      cur_item = {
          id: x.id,
          name: x.name,
          status: x.get_status,
          started_at: x.created_at.to_formatted_s(:long),
          # opened: x.opened,
          # winner: x.get_winner,
          # config: x.get_config
      }
      cur_item
    }
  end
end