class HabitLogsController < ApplicationController
  before_action :set_habit, only: [:index, :new, :create, :update]
  before_action :set_habit_log, only: [:update]

  def index
    @habit_logs = @habit.habit_logs.order(date: :desc)
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
      flash.now[:success] = 'Habit log was successfully updated.'
      redirect_target = determine_redirect_target

      respond_to do |format|
        format.html { redirect_to redirect_target }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "shared/flash_message"),
            turbo_stream.replace("unlogged_habit_logs_alert", partial: "shared/unlogged_habit_logs_alert"),
            turbo_stream.replace("unlogged_habit_log_#{@habit_log.id}", partial: "shared/unlogged_habit_log", locals: { log: @habit_log })
          ]
        end
      end
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

  def determine_redirect_target
    referrer = request.referrer
    if referrer.include?(habit_path(@habit))
      habit_path(@habit)
    elsif referrer.include?(habit_habit_logs_path(@habit))
      habit_habit_logs_path(@habit)
    elsif referrer.include?(unlogged_habit_logs_path)
      unlogged_habit_logs_path
    else
      habit_path(@habit)
    end
  end
end
