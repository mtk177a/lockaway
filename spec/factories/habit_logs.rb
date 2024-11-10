FactoryBot.define do
  factory :habit_log do
    date { Date.today }
    status { 'not_completed' }
    habit
  end
end
