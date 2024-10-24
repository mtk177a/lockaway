FactoryBot.define do
  factory :habit do
    name { "Test Habit" }
    habit_type { 1 }
    start_date { Date.today }
    user
  end
end
