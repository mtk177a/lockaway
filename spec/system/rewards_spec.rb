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

  it '条件達成により報酬を獲得できること', js: true do
    habit = create(:habit, user: user, name: '今日の運動', start_date: Date.today)
    reward = create(:reward, name: '1日達成', threshold: 1)

    visit habit_path(habit)

    expect(page).to have_css("#habit_#{habit.id}", wait: 5)
    within("#habit_#{habit.id}") do
      click_button '達成した'
    end

    visit user_rewards_path(user)
    expect(page).to have_content(reward.name, wait: 5)
  end
end
