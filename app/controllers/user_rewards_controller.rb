class UserRewardsController < ApplicationController
  def index
    @q = HabitReward.includes(:habit, :reward)
                    .where(habits: { user_id: current_user.id })
                    .ransack(params[:q])
    @user_rewards = @q.result.order(created_at: :desc).page(params[:page])
  end
end
