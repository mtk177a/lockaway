class HabitLogsController < ApplicationController
  before_action :set_habit, only: [:index, :new, :create, :update]
  before_action :set_habit_log, only: [:update]

  def index
    @habit_logs = @habit.habit_logs.order(:date)
    if params[:filter] == 'incomplete'
      @habit_logs = @habit_logs.where(status: nil)
    end
  end

  def new
    @habit_log = @habit.habit_logs.new
  end

  def create
    @habit_log = @habit.habit_logs.new(habit_log_params)
    @habit_log.date = Date.today
    if @habit_log.save
      redirect_to habit_habit_logs_path(@habit), success: 'Habit log was successfully created.'
    else
      render :new
    end
  end

  def update
    if @habit_log.update(habit_log_params)
      redirect_to habit_path(@habit), success: 'Habit log was successfully updated.'
    else
      render :index
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end

  def set_habit_log
    @habit_log = @habit.habit_logs.find(params[:id])
  end

  def habit_log_params
    params.require(:habit_log).permit(:status)
  end
end
