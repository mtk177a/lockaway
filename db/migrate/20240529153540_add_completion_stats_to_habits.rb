class AddCompletionStatsToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :total_completed_days, :integer, default: 0
    add_column :habits, :continuous_completed_days, :integer, default: 0
    add_column :habits, :completion_rate, :float, default: 0.0
  end
end
