class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: true
  validates :habit_type, presence: true
  validates :start_date, presence: true
end
