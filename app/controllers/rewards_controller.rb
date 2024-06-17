class RewardsController < ApplicationController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def available_rewards
    @available_rewards = Reward.all.reject { |reward| current_user.rewards.include?(reward) }
  end
end
