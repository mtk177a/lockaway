class UnloggedHabitLogsController < ApplicationController
  def index
    @unlogged_habit_logs = HabitLog.joins(:habit)
                                   .where(habits: { user_id: current_user.id }, status: nil)
  end
end
