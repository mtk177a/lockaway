class Reward < ApplicationRecord
  has_many :habit_rewards, dependent: :destroy
  has_many :habits, through: :habit_rewards

  enum condition_type: { continuous_days: 0, total_days: 1 }

  validates :name, presence: true
  validates :condition_type, presence: true
  validates :threshold, presence: true, numericality: { only_integer: true }
end
