class HabitReward < ApplicationRecord
  belongs_to :habit
  belongs_to :reward
end
