class UnloggedHabitLogsController < ApplicationController
  def index
    @unlogged_habit_logs = HabitLog.joins(:habit)
                                   .where(habits: { user_id: current_user.id }, date: Date.today, status: nil)
  end
end
