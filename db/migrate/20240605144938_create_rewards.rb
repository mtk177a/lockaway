class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.string :name,            null: false
      t.text :description
      t.string :condition_type,  null: false
      t.integer :threshold,      null: false

      t.timestamps
    end
  end
end
