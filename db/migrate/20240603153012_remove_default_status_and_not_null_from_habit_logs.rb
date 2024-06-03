class RemoveDefaultStatusAndNotNullFromHabitLogs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :habit_logs, :status, nil
    change_column_null :habit_logs, :status, true
  end
end

