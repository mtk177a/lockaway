class Admin::HabitsController < Admin::BaseController
  before_action :set_habit, only: [:show, :destroy]

  def index
    @habits = Habit.all
  end

  def show
  end

  def destroy
    @habit.destroy
    redirect_to admin_habits_path, notice: 'Habit was successfully deleted.'
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end
end
