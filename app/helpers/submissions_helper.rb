module SubmissionsHelper

  def get_info (arg)
    x = arg[:submission]
    keys = arg[:keys]
    cur_item = {
        id: x.id,
        name: x.name,
        lang: x.compiler,
        creator: "N/A",
        opened: x.opened,
        primary: x.used_for_tours,
    }

    if not keys.nil? and keys.include? "code"
      cur_item[:code] = x.code
    end

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

    unless keys.nil?
      return cur_item.slice(*keys.map {|s| s.parameterize.underscore.to_sym})
    end
    cur_item
  end

  def get_data_for_table (submissions, keys)
    @submissions_data = (submissions.map { |x| get_info ({
        submission: x,
        keys: keys
    })})
  end
end
