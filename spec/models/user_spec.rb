require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'ユーザー名が存在する場合、有効であること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスが一意でなければ無効であること' do
      FactoryBot.create(:user, email: 'testuser@example.com')
      user = FactoryBot.build(:user, email: 'testuser@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'パスワードが3文字以上であること' do
      user = FactoryBot.build(:user, password: 'pw', password_confirmation: 'pw')
      user.valid?
      expect(user.errors[:password]).to include('が短すぎます')
    end

    it 'パスワードが一致していない場合、無効であること' do
      user = FactoryBot.build(:user, password: 'password', password_confirmation: 'mismatch')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('が一致しません')
    end

    it 'ユーザー名が空の場合、無効であること' do
      user = FactoryBot.build(:user, username: '')
      user.valid?
      expect(user.errors[:username]).to include('を入力してください')
    end
  end

  describe 'アソシエーション' do
    it 'ユーザーが複数の習慣を持つことができる' do
      user = FactoryBot.create(:user)
      habit = FactoryBot.create(:habit, user: user)
      expect(user.habits).to include(habit)
    end
  end

  describe 'カスタムメソッド' do
    it 'own?メソッドが正しく動作する' do
      user = FactoryBot.create(:user)
      habit = FactoryBot.create(:habit, user: user)
      expect(user.own?(habit)).to be true
    end
  end
end
