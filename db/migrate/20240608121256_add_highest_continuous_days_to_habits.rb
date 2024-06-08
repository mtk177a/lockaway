class AddHighestContinuousDaysToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :highest_continuous_days, :integer, default: 0
  end
end
