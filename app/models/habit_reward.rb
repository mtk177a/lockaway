class HabitReward < ApplicationRecord
  belongs_to :habit
  belongs_to :reward

  validates :habit_id, presence: true
  validates :reward_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at habit_id id reward_id updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[habit reward]
  end
end
