class PublicRewardsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @q = HabitReward.joins(habit: :user)
                    .where(habits: { public: true })
                    .ransack(params[:q])
    @habit_rewards = @q.result.includes(:habit, :reward).order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html # 通常のHTMLレンダリング
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'reward_list', # Turbo Streamで置き換える部分のID
          partial: 'shared/reward_list', locals: { rewards: @habit_rewards }
        )
      end
    end
  end
end
