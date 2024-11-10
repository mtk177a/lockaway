FactoryBot.define do
  factory :reward do
    name { "Test Reward" }
    description { "Test Reward Description" }
    condition_type { "continuous_days" }
    threshold { 1 }
    habit_type { 1 }
  end
end
