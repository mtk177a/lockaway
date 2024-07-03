class Reward < ApplicationRecord
  has_many :habit_rewards, dependent: :destroy
  has_many :habits, through: :habit_rewards

  enum condition_type: { continuous_days: 0, total_days: 1 }
  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: { message: :blank }
  validates :condition_type, presence: { message: :blank }
  validates :threshold, presence: { message: :blank }, numericality: { only_integer: true, message: :not_a_number }
  validates :habit_type, presence: { message: :blank }

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description condition_type habit_type threshold created_at updated_at]
  end
end
