class UnloggedHabitLogsController < ApplicationController
  def index
    @unlogged_habit_logs = HabitLog.joins(:habit)
                                   .where(habits: { user_id: current_user.id }, status: nil)
                                   .order('habits.created_at DESC, date DESC')
  end
end
