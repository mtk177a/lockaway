class UserRewardsController < ApplicationController
  def index
    @q = HabitReward.includes(:habit, :reward)
                    .where(habits: { user_id: current_user.id })
                    .ransack(params[:q])
    @user_rewards = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show
    @habit_reward = HabitReward.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('modal', partial: 'shared/reward_modal', locals: { reward: @habit_reward })
      end
    end
  end
end
