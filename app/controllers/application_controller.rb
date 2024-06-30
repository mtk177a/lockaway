class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :info, :success, :warning, :error
  before_action :set_unlogged_habit_logs

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def set_unlogged_habit_logs
    if current_user
      @unlogged_habit_logs = HabitLog.joins(:habit)
                                     .where(habits: { user_id: current_user.id }, status: nil)
    end
  end

  helper_method :current_user
end
