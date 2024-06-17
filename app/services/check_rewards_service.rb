class CheckRewardsService
  def initialize(habit)
    @habit = habit
  end

  def call
    Reward.where(habit_type: @habit.habit_type).find_each do |reward|
      case reward.condition_type
      when 'continuous_days'
        apply_reward(reward) if @habit.continuous_completed_days >= reward.threshold
      when 'total_days'
        apply_reward(reward) if @habit.total_completed_days >= reward.threshold
      end
    end
  end

  private

  def apply_reward(reward)
    unless @habit.rewards.include?(reward)
      @habit.rewards << reward
      # ここでユーザーに通知を送るなどの処理を追加
    end
  end
end
