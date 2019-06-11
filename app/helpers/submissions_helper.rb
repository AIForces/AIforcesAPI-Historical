module SubmissionsHelper
  def get_data_for_table (submissions)
    submissions.map {|x|
      cur_item = {
          id: x.id,
          name: x.name,
          used_for_ch: x.used_for_ch,
          used_for_tours: x.used_for_tours,
          lang: x.compiler,
          creator: "N/A",
          opened: x.opened
      }
      if x.challenge.nil?
        cur_item[:status] = 'Нет проверки'
        cur_item[:verdict] = 'N/A'
      else
        cur_item[:status] = x.challenge.get_status
        cur_item[:verdict] = x.challenge.player_1_verdict
      end

      unless x.user.nil?
        cur_item[:creator] = x.user.username
      end

      cur_item[:created_at] = x.created_at.to_formatted_s(:short)
      cur_item
    }
  end
end
