class CreateHabitLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_logs do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
