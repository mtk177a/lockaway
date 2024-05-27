class HabitLog < ApplicationRecord
  belongs_to :habit

  enum status: { incomplete: 0, complete: 1 }

  validates :date, presence: true
  validates :status, presence: true
  validates :habit_id, uniqueness: { scope: :date, message: "has already been logged for this date" }
  validate :date_cannot_be_before_habit_start

  def date_cannot_be_before_habit_start
    if date.present? && date < habit.start_date
      errors.add(:date, "can't be before the habit start date")
    end
  end
end
