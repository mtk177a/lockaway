namespace :initial_tasks do
  desc "Generate habit logs for all existing habits"
  task generate_all_habit_logs: :environment do
    Habit.find_each do |habit|
      start_date = habit.start_date.to_date
      (start_date..Date.today).each do |date|
        HabitLog.find_or_create_by(habit: habit, date: date) do |log|
          log.status = nil
        end
      end
    end
  end
end
