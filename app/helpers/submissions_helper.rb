module SubmissionsHelper
  def lang_to_option lang
    mapper = {
        'GNU C++ 17' => 'cpp',
        'Python 3.7' => 'python'
    }
    Rails.logger.debug(lang.inspect)
    Rails.logger.debug(mapper[lang])
    mapper[lang]
  end
end
