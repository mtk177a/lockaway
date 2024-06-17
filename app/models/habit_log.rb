class HabitLog < ApplicationRecord
  belongs_to :habit

  enum status: { not_completed: 0, completed: 1 }

  validates :date, presence: true
  validates :habit_id, uniqueness: { scope: :date, message: "has already been logged for this date" }
  validate :date_cannot_be_before_habit_start

  after_save :check_rewards, if: :completed?

  def date_cannot_be_before_habit_start
    if date.present? && date < habit.start_date
      errors.add(:date, "can't be before the habit start date")
    end
  end

  private

  def check_rewards
    habit.check_and_apply_rewards if completed?
  end
end
