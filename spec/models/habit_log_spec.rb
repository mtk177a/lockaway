require 'rails_helper'

RSpec.describe HabitLog, type: :model do
  describe 'バリデーション' do
    it '日付が存在しない場合は無効であること' do
      habit_log = FactoryBot.build(:habit_log, date: nil)
      habit_log.valid?
      expect(habit_log.errors[:date]).to include('を入力してください')
    end

    it '同じ日付で同じ習慣IDが重複する場合は無効であること' do
      habit = FactoryBot.create(:habit, start_date: Date.today - 1.day)
      habit.habit_logs.destroy_all
      FactoryBot.create(:habit_log, habit: habit, date: Date.today)
      duplicate_log = FactoryBot.build(:habit_log, habit: habit, date: Date.today)

      duplicate_log.valid?
      expect(duplicate_log.errors[:habit_id]).to include('はすでに存在します')
    end

    it '日付が習慣の開始日より前の場合は無効であること' do
      habit = FactoryBot.create(:habit, start_date: Date.today)
      habit.habit_logs.destroy_all
      habit_log = FactoryBot.build(:habit_log, habit: habit, date: Date.yesterday)

      habit_log.valid?
      expect(habit_log.errors[:date]).to include('習慣の開始日より前の日付は設定できません')
    end
  end

  describe 'アソシエーション' do
    it 'Habitに属していること' do
      assoc = HabitLog.reflect_on_association(:habit)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe 'コールバック' do
    it 'completed状態のときに報酬をチェックする' do
      habit = FactoryBot.create(:habit)
      allow(habit).to receive(:check_and_apply_rewards)

      # 生成されたhabit_logを取得し、ステータスを変更して保存
      habit_log = habit.habit_logs.first
      habit_log.update(status: 'completed')

      expect(habit).to have_received(:check_and_apply_rewards)
    end

    it 'not_completed状態のときは報酬をチェックしない' do
      habit = FactoryBot.create(:habit)
      allow(habit).to receive(:check_and_apply_rewards)

      # 生成されたhabit_logを取得し、ステータスをnot_completedにして保存
      habit_log = habit.habit_logs.first
      habit_log.update(status: 'not_completed')

      expect(habit).not_to have_received(:check_and_apply_rewards)
    end
  end
end
