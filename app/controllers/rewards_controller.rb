class RewardsController < ApplicationController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def user_rewards
    @user_rewards = current_user.rewards
  end
end
