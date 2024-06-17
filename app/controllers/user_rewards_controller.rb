class UserRewardsController < ApplicationController
  def index
    @user_rewards = HabitReward.includes(:habit, :reward).where(habits: { user_id: current_user.id })
  end
end
