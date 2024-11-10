FactoryBot.define do
  factory :habit do
    name { "Test Habit" }
    habit_type { :good }
    start_date { Date.today - 3.days }
    public { true }
    user

    trait :with_completed_logs do
      transient do
        log_days { 3 }
      end

      after(:create) do |habit, evaluator|
        habit.habit_logs.limit(evaluator.log_days).update_all(status: 'completed')
      end
    end

    trait :with_varied_logs do
      after(:create) do |habit|
        habit.habit_logs.limit(2).update_all(status: 'completed') # 最初の2つのログを`completed`に設定
        habit.habit_logs.offset(2).limit(1).update_all(status: 'not_completed') # 3番目のログを`not_completed`に設定
        habit.habit_logs.offset(3).update_all(status: 'completed') # 残りのログを`completed`に設定
      end
    end

    # `highest_continuous_days` 用のトレイト
    trait :with_highest_streak_logs do
      after(:create) do |habit|
        habit.habit_logs.limit(3).update_all(status: 'completed') # 最初の3つのログを`completed`に設定
        habit.habit_logs.offset(3).limit(1).update_all(status: 'not_completed') # 4番目のログを`not_completed`に設定
      end
    end

    # `continuous_completed_days` 用のトレイト
    trait :with_continuous_streak_logs do
      after(:create) do |habit|
        habit.habit_logs.limit(2).update_all(status: 'completed') # 最初の2つのログを`completed`に設定
        habit.habit_logs.offset(2).limit(1).update_all(status: 'not_completed') # 3番目のログを`not_completed`に設定
      end
    end

    # `completion_rate` 用のトレイト
    trait :with_partial_completed_logs do
      after(:create) do |habit|
        habit.habit_logs.limit(2).update_all(status: 'completed')         # 最初の2つのログを`completed`に設定
        habit.habit_logs.offset(2).limit(1).update_all(status: 'not_completed') # 3番目のログを`not_completed`に設定
        habit.habit_logs.offset(3).limit(1).update_all(status: 'completed') # 4番目のログも`completed`に設定
      end
    end
  end
end
