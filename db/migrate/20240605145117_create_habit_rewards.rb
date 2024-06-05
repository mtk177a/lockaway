class CreateHabitRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_rewards do |t|
      t.references :habit, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
