class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :info, :success, :warning, :error
  before_action :set_unlogged_habit_logs

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def require_admin_login
    unless current_admin
      redirect_to admin_login_path, alert: "Please login as an admin to access this section."
    end
  end

  def set_unlogged_habit_logs
    if current_user
      @unlogged_habit_logs = current_user.habits
                                         .joins(:habit_logs)
                                         .where(habit_logs: { date: Date.today, status: nil })
    end
  end

  helper_method :current_admin, :logged_in?
end
