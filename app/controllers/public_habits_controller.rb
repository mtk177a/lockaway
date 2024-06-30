class PublicHabitsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @q = Habit.public_habits.ransack(params[:q])
    @habits = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show
    @habit = Habit.public_habits.find(params[:id])
  end
end
