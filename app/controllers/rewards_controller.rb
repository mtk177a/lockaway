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

  def available_rewards
    @available_rewards = Reward.all.reject { |reward| current_user.rewards.include?(reward) }
  end
end
