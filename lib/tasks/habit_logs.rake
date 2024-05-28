namespace :habit_logs do
  desc "Generate habit logs for all habits"
  task generate: :environment do
    Habit.find_each do |habit|
      start_date = habit.start_date
      (start_date..Date.today).each do |date|
        HabitLog.find_or_create_by(habit: habit, date: date) do |log|
          log.completed = false
        end
      end
    end
  end
end
