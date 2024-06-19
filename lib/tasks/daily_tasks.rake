namespace :daily_tasks do
  desc "Create habit logs for the new day"
  task create_habit_logs: :environment do
    Time.use_zone('Asia/Tokyo') do
      Habit.where('start_date <= ?', Date.current).find_each do |habit|
        unless habit.habit_logs.exists?(date: Date.current)
          habit.habit_logs.create(date: Date.current, status: nil)
        end
      end
    end
  end
end
