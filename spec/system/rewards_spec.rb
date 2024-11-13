require 'rails_helper'

RSpec.describe '報酬機能', type: :system do
  let(:user) { create(:user) }

  before do
    login_user(email: user.email, password: 'password')
    expect(page).to have_content('ログインに成功しました')
  end

  it '報酬が正しく表示されること' do
    reward = create(:reward, name: '1日達成', threshold: 1)
    visit rewards_path

    expect(page).to have_content('1日達成')
  end

  it '条件達成により報酬を獲得できること' do
    habit = create(:habit, user: user, name: '今日の運動', start_date: Date.today)
    reward = create(:reward, name: '1日達成', threshold: 1)

    visit habit_path(habit)

    log = habit.habit_logs.first
    within("#habit_log_#{log.id}") do
      click_button '達成した'
    end

    visit user_rewards_path(user)
    expect(page).to have_content(reward.name, wait: 10)
  end
end
