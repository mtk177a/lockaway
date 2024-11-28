class PublicRewardsController < ApplicationController
  skip_before_action :require_login, only: [:index, :search]

  def index
    @q = HabitReward.joins(habit: :user)
                    .where(habits: { public: true })
                    .ransack(params[:q])
    @habit_rewards = @q.result.includes(:habit, :reward).order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html # 通常のHTMLレンダリング
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'reward_list',
          partial: 'shared/reward_list', locals: { rewards: @habit_rewards }
        )
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
