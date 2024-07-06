class PublicRewardsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @q = HabitReward.joins(habit: :user)
                    .where(habits: { public: true })
                    .ransack(params[:q])
    @habit_rewards = @q.result.includes(:habit, :reward).order(created_at: :desc).page(params[:page])
  end
end
