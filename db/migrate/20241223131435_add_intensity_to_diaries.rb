class AddIntensityToDiaries < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:diaries, :intensity)
      add_column :diaries, :intensity, :integer
    end
  end
end