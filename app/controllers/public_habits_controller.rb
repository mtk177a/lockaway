class PublicHabitsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @habits = Habit.public_habits
    @habits = @habits.order(created_at: :desc) if params[:sort] == 'newest'
    @habits = @habits.order(created_at: :asc) if params[:sort] == 'oldest'
    @habits = @habits.where(habit_type: params[:habit_type]) if params[:habit_type].present?
    @habits = @habits.page(params[:page])
  end
end
