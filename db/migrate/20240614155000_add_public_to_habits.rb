class AddPublicToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :public, :boolean, default: false, null: false
  end
end
