class PublicRewardsController < ApplicationController
  def index
    @habit_rewards = HabitReward.includes(:habit, :reward, habit: :user).order(created_at: :desc).page(params[:page])
    @habit_rewards = @habit_rewards.where(habits: { habit_type: params[:habit_type] }) if params[:habit_type].present?
    @habit_rewards = @habit_rewards.joins(habit: :user).where(users: { username: params[:username] }) if params[:username].present?
  end
end
