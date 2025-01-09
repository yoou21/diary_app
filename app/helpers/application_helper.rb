module ApplicationHelper
  def emotion_color(emotion)
    case emotion.name
    when '嬉しい'
      '#FFEB3B' # 黄色
    when '悲しい'
      '#2196F3' # 青
    when '楽しい'
      '#8BC34A' # 緑
    when '怒り'
      '#F44336' # 赤
    else
      '#9E9E9E' # グレー（デフォルト）
    end
  end
end