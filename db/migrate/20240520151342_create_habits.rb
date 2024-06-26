class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.references :user,       null: false, foreign_key: true
      t.string :name,           null: false
      t.integer :habit_type,    null: false
      t.text :description
      t.datetime :start_date,   null: false

      t.timestamps
    end
  end
end
