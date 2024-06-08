class HabitReward < ApplicationRecord
  belongs_to :habit
  belongs_to :reward

  validates :habit_id, presence: true
  validates :reward_id, presence: true
end
