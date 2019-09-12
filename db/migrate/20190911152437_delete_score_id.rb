class DeleteScoreId < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :score_id
  end
end
