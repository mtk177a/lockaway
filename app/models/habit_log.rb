class HabitLog < ApplicationRecord
  belongs_to :habit

  enum status: { incomplete: 0, complete: 1 }

  validates :date, presence: true
  validates :status, presence: true
  validates :habit_id, uniqueness: { scope: :date, message: "has already been logged for this date" }
end
