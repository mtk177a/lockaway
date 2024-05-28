class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  after_create :generate_initial_logs

  enum habit_type: { good: 0, bad: 1 }

  validates :name, presence: true
  validates :habit_type, presence: true
  validates :start_date, presence: true

  private

  def generate_initial_logs
    (start_date..Date.today).each do |date|
      habit_logs.find_or_create_by(date: date)
    end
  end
end
