require 'rails_helper'

RSpec.describe 'ユーザー認証', type: :system do
  include AuthenticationHelpers

  before(:each) do
    User.destroy_all
  end

  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  describe 'ユーザー登録' do
    it '正常に新規登録ができること' do
      visit new_user_path
      fill_in 'ユーザー名', with: 'TestUser'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button '登録'

      expect(page).to have_content('ユーザーが正常に作成されました。')
    end

    it '無効なデータでは登録に失敗すること' do
      visit new_user_path
      fill_in 'ユーザー名', with: 'TestUser'
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'differentpassword'
      click_button '登録'

      expect(page).to have_content('ユーザーを作成できませんでした。')
    end
  end

  describe 'ログイン' do
    it '正しい情報でログインができること' do
      login_user(email: user.email, password: 'password')
      expect(page).to have_content('ログインに成功しました')
    end

    it '無効な情報でログインに失敗すること' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'

      expect(page).to have_content('ログインに失敗しました')
    end
  end

  describe 'ログアウト' do
    it 'ログアウトが正常に動作すること' do
      login_user(email: user.email, password: 'password')
      expect(page).to have_content('ログインに成功しました')
      expect(page).to have_selector('.dropdown .btn-circle')
      find('.dropdown .btn-circle').click
      click_link 'ログアウト'

      expect(page).to have_content('ログアウトしました')
    end
  end
end
