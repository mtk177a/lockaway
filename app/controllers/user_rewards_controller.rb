class UserRewardsController < ApplicationController
  def index
    @q = HabitReward.includes(:habit, :reward)
                    .where(habits: { user_id: current_user.id })
                    .ransack(params[:q])
    @user_rewards = @q.result.order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'reward_list',
          partial: 'shared/reward_list', locals: { rewards: @user_rewards }
        )
      end
    end
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

  def search
    @rewards = Reward.where("name LIKE ?", "%#{params[:q]}%").limit(10)
    respond_to do |format|
      format.js { render partial: 'shared/reward_search_results' }
    end
  end
end
