class AddPublicToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :public, :boolean
  end
end
