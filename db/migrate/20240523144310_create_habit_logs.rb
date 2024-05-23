class CreateHabitLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_logs do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :habit_logs, [:habit_id, :date], unique: true
  end
end
