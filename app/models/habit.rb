class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy
  has_many :habit_rewards, dependent: :destroy
  has_many :rewards, through: :habit_rewards

  after_create :generate_initial_logs
  after_save :update_completion_stats

  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: true
  validates :habit_type, presence: true
  validates :start_date, presence: true

  scope :public_habits, -> { where(public: true) }

  def total_completed_days
    habit_logs.where(status: 'completed').count
  end

  def continuous_completed_days
    logs = habit_logs.order(date: :desc)
    count = 0
    logs.each do |log|
      break if log.status != 'completed'
      count += 1
    end
    count
  end

  def highest_continuous_days
    logs = habit_logs.order(date: :asc)
    max_streak = 0
    current_streak = 0

    logs.each do |log|
      if log.status == 'completed'
        current_streak += 1
        max_streak = [max_streak, current_streak].max
      else
        current_streak = 0
      end
    end

    max_streak
  end

  def completion_rate
    total_logs = habit_logs.count
    completed_logs = habit_logs.where(status: 'completed').count
    total_logs > 0 ? (completed_logs.to_f / total_logs * 100).round(2) : 0.0
  end

  def check_and_apply_rewards
    Reward.all.each do |reward|
      case reward.condition_type
      when 'continuous_days'
        apply_reward(reward) if continuous_completed_days >= reward.threshold
      when 'total_days'
        apply_reward(reward) if total_completed_days >= reward.threshold
      end
    end
  end

  private

  def generate_initial_logs
    (start_date.to_date..Date.today).each do |date|
      habit_logs.find_or_create_by(date: date)
    end
  end

  def update_completion_stats
    update_columns(
      total_completed_days: total_completed_days,
      continuous_completed_days: continuous_completed_days,
      highest_continuous_days: highest_continuous_days,
      completion_rate: completion_rate
    )
  end

  def apply_reward(reward)
    unless self.rewards.include?(reward)
      self.rewards << reward
      # ここでユーザーに通知を送るなどの処理を追加
    end
  end
end
