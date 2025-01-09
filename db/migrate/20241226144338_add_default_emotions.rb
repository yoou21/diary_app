class AddDefaultEmotions < ActiveRecord::Migration[7.2]
  def up
    # すべてのユーザーにデフォルトの感情を追加（重複を防ぐ）
    User.find_each do |user|
      unless user.emotions.exists?(date: Date.today, name: '嬉しい')
        user.emotions.create(name: '嬉しい', word: '喜び', score: 3, date: Date.today)
      end
      unless user.emotions.exists?(date: Date.today, name: '悲しい')
        user.emotions.create(name: '悲しい', word: '悲しみ', score: -1, date: Date.today)
      end
      unless user.emotions.exists?(date: Date.today, name: '楽しい')
        user.emotions.create(name: '楽しい', word: '楽しみ', score: 2, date: Date.today)
      end
      unless user.emotions.exists?(date: Date.today, name: '怒り')
        user.emotions.create(name: '怒り', word: '怒り', score: -2, date: Date.today)
      end
    end
  end

  def down
    # もしマイグレーションをロールバックしたときに感情データを削除
    Emotion.where(name: ['嬉しい', '悲しい', '楽しい', '怒り']).destroy_all
  end
end