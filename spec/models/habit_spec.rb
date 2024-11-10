require 'rails_helper'

RSpec.describe Habit, type: :model do
  before(:each) do
    Habit.destroy_all
    HabitLog.destroy_all
  end

  describe 'バリデーション' do
    it '習慣名が空の場合、無効であること' do
      habit = FactoryBot.build(:habit, name: nil)
      habit.valid?
      expect(habit.errors[:name]).to include('を入力してください')
    end

    it '習慣タイプが空の場合、無効であること' do
      habit = FactoryBot.build(:habit, habit_type: nil)
      habit.valid?
      expect(habit.errors[:habit_type]).to include('を入力してください')
    end

    it '開始日が空の場合、無効であること' do
      habit = FactoryBot.build(:habit, start_date: nil)
      habit.valid?
      expect(habit.errors[:start_date]).to include('を入力してください')
    end

    it '全ての値が存在する場合、有効であること' do
      habit = FactoryBot.build(:habit)
      expect(habit).to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'ユーザーが複数の習慣を持つことができる' do
      user = FactoryBot.create(:user)
      habit = FactoryBot.create(:habit, user: user)
      expect(user.habits).to include(habit)
    end

    it '習慣が複数のログを持つことができる' do
      habit = FactoryBot.create(:habit)
      expect(habit.habit_logs.count).to be > 0
    end

    it '習慣が複数の報酬を持つことができる' do
      habit = FactoryBot.create(:habit)
      expect(habit.rewards).to be_empty
    end

    it '習慣が複数の報酬を獲得できる' do
      habit = FactoryBot.create(:habit)
      reward = FactoryBot.create(:reward, habit_type: habit.habit_type)
      habit.habit_rewards.create(reward: reward)
      expect(habit.rewards).to include(reward)
    end
  end

  describe 'スコープ' do
    describe '.public_habits' do
      it '公開されている習慣のみを返すこと' do
        public_habit = FactoryBot.create(:habit, public: true)
        private_habit = FactoryBot.create(:habit, public: false)

        expect(Habit.public_habits).to include(public_habit)
        expect(Habit.public_habits).not_to include(private_habit)
      end
    end
  end

  describe 'カスタムメソッド' do
    it 'check_and_apply_rewardsメソッドがtotal_days条件に基づく報酬を適用すること' do
      habit = FactoryBot.create(:habit, :with_completed_logs, log_days: 2)
      reward = FactoryBot.create(:reward, habit_type: habit.habit_type, condition_type: 'total_days', threshold: 2)

      habit.check_and_apply_rewards
      habit.reload
      expect(habit.rewards).to include(reward)
    end

    it 'apply_rewardメソッドが報酬を適用すること' do
      habit = FactoryBot.create(:habit)
      reward = FactoryBot.create(:reward, habit_type: habit.habit_type)
      habit.send(:apply_reward, reward)
      expect(habit.rewards).to include(reward)
    end
  end

  describe 'インスタンスメソッド' do
    it 'total_completed_daysメソッドが正しく動作する' do
      habit = FactoryBot.create(:habit, :with_completed_logs, log_days: 2)
      habit.send(:update_completion_stats)
      expect(habit.total_completed_days).to eq(2)
    end

    it 'continuous_completed_daysメソッドが正しく動作する' do
      habit = FactoryBot.create(:habit, :with_continuous_streak_logs)
      habit.send(:update_completion_stats)
      expect(habit.continuous_completed_days).to eq(2)
    end

    it 'highest_continuous_daysメソッドが正しく動作する' do
      habit = FactoryBot.create(:habit, :with_highest_streak_logs)
      habit.send(:update_completion_stats)
      expect(habit.highest_continuous_days).to eq(3)
    end

    it 'completion_rateメソッドが正しく動作すること' do
      habit = FactoryBot.create(:habit, :with_partial_completed_logs)
      habit.send(:update_completion_stats)

      # habit_logsのステータスと日付を確認
      habit.habit_logs.each do |log|
        puts "HabitLog: date=#{log.date}, status=#{log.status}"
      end

      expect(habit.completion_rate).to be_within(0.1).of(75.0)
    end
  end

  describe 'プライベートメソッド' do
    it 'generate_initial_logsメソッドがログを生成すること' do
      habit = FactoryBot.create(:habit, start_date: Date.today - 3.days)
      expect(habit.habit_logs.count).to eq(4)
    end

    it 'update_completion_statsメソッドが完了ステータスを更新すること' do
      habit = FactoryBot.create(:habit, :with_completed_logs, log_days: 4)
      habit.habit_logs.update_all(status: 'completed')
      habit.send(:update_completion_stats)
      habit.reload

      expect(habit.total_completed_days).to eq(4)
      expect(habit.continuous_completed_days).to eq(4)
      expect(habit.highest_continuous_days).to eq(4)
      expect(habit.completion_rate).to eq(100.0)
    end
  end
end
