class AddHabitTypeToRewards < ActiveRecord::Migration[7.1]
  def change
    add_column :rewards, :habit_type, :integer
  end
end
