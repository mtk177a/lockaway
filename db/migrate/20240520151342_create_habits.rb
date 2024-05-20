class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :habit_type
      t.text :description
      t.datetime :start_date

      t.timestamps
    end
  end
end
