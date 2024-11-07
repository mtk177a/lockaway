require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'バリデーション' do
    it '名前が空の場合、無効であること' do
      reward = FactoryBot.build(:reward, name: nil)
      reward.valid?
      expect(reward.errors[:name]).to include('を入力してください')
    end

    it 'condition_typeが空の場合、無効であること' do
      reward = FactoryBot.build(:reward, condition_type: nil)
      reward.valid?
      expect(reward.errors[:condition_type]).to include('を入力してください')
    end

    it 'thresholdが空の場合、無効であること' do
      reward = FactoryBot.build(:reward, threshold: nil)
      reward.valid?
      expect(reward.errors[:threshold]).to include('を入力してください')
    end

    it 'thresholdが整数でない場合、無効であること' do
      reward = FactoryBot.build(:reward, threshold: 'abc')
      reward.valid?
      expect(reward.errors[:threshold]).to include('は数値でなければなりません')
    end

    it 'habit_typeが空の場合、無効であること' do
      reward = FactoryBot.build(:reward, habit_type: nil)
      reward.valid?
      expect(reward.errors[:habit_type]).to include('を入力してください')
    end

    it '全ての値が存在する場合、有効であること' do
      reward = FactoryBot.build(:reward)
      expect(reward).to be_valid
    end
  end

  describe 'アソシエーション' do
    it '複数のHabitに関連付けられていること' do
      assoc = Reward.reflect_on_association(:habits)
      expect(assoc.macro).to eq :has_many
    end

    it '複数のHabitRewardに関連付けられていること' do
      assoc = Reward.reflect_on_association(:habit_rewards)
      expect(assoc.macro).to eq :has_many
    end
  end
end
