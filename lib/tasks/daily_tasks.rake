namespace :daily_tasks do
  desc "Create habit logs for the new day"
  task create_habit_logs: :environment do
    Habit.where('start_date <= ?', Date.today).find_each do |habit|
      unless habit.habit_logs.exists?(date: Date.today)
        habit.habit_logs.create(date: Date.today)
      end
    end
  end
end
