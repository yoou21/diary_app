class AddTimestampsToEmotions < ActiveRecord::Migration[7.2]
  def change
    # もし created_at と updated_at が存在しない場合にのみ追加する
    unless column_exists?(:emotions, :created_at) && column_exists?(:emotions, :updated_at)
      add_timestamps :emotions, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
  end
end
