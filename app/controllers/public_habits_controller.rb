class PublicHabitsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @q = Habit.public_habits.ransack(params[:q])
    @habits = @q.result.order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html # デフォルトのHTMLレンダリング
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'habit_list',
          partial: 'shared/habit_list',
          locals: { habits: @habits, context: :public_habits }
        )
      end
    end
  end

  def show
    @habit = Habit.public_habits.find(params[:id])
  end
end
