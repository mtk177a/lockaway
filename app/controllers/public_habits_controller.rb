class PublicHabitsController < ApplicationController
  def index
    @habits = Habit.public_habits.page(params[:page]).per(10)
    # ソートとフィルタリングのロジックを追加
  end
end
