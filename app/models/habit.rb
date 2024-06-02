class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  after_create :generate_initial_logs
  after_save :update_completion_stats

  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: true
  validates :habit_type, presence: true
  validates :start_date, presence: true

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

  def completion_rate
    total_logs = habit_logs.count
    completed_logs = habit_logs.where(status: 'completed').count
    total_logs > 0 ? (completed_logs.to_f / total_logs * 100).round(2) : 0.0
  end

  private

  def generate_initial_logs
    (start_date..Date.today).each do |date|
      habit_logs.find_or_create_by(date: date)
    end
  end

  def update_completion_stats
    update_columns(
      total_completed_days: total_completed_days,
      continuous_completed_days: continuous_completed_days,
      completion_rate: completion_rate
    )
  end
end
