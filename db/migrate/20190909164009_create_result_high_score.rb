class CreateResultHighScore < ActiveRecord::Migration[6.0]
  def change
    create_table :result_high_scores do |t|
      t.integer :user_id
      t.integer :high_score
      t.integer :game_id
    end
  end
end
