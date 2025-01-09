# app/helpers/dashboard_helper.rb

module DashboardHelper
  def emotion_color(emotion)
    return 'white' unless emotion

    case emotion.score
    when 1..2
      'red' # ネガティブな感情
    when 3..4
      'yellow' # 普通
    else
      'green' # ポジティブな感情
    end
  end
end
