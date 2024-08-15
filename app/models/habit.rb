class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy
  has_many :habit_rewards, dependent: :destroy
  has_many :rewards, through: :habit_rewards

  after_create :generate_initial_logs
  after_save :update_completion_stats

  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: { message: :blank }
  validates :habit_type, presence: { message: :blank }
  validates :start_date, presence: { message: :blank }

  scope :public_habits, -> { where(public: true) }

  def total_completed_days
    habit_logs.where(status: 'completed').count
  end

  def continuous_completed_days
    logs = habit_logs.order(date: :asc) # 日付順に並べる
    count = 0

    # 連続完了日数をカウント
    logs.each do |log|
      break if log.status != 'completed' # 未完了のログがあればカウントを中断
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
    acquired_rewards = []
    applicable_rewards = Reward.where(habit_type: self.habit_type)

    applicable_rewards.each do |reward|
      case reward.condition_type
      when 'continuous_days'
        if continuous_completed_days >= reward.threshold
          apply_reward(reward)
          acquired_rewards << HabitReward.find_by(habit: self, reward: reward)
        end
      when 'total_days'
        if total_completed_days >= reward.threshold
          apply_reward(reward)
          acquired_rewards << HabitReward.find_by(habit: self, reward: reward)
        end
      end
    end
    acquired_rewards
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[completion_rate continuous_completed_days created_at description habit_type highest_continuous_days id name public start_date total_completed_days updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[habit_logs habit_rewards rewards user]
  end

  ransacker :habit_type, formatter: proc { |v| habit_types[v] } do |parent|
    parent.table[:habit_type]
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
