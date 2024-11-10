require 'rails_helper'

RSpec.describe '習慣管理', type: :system do
  user = FactoryBot.create(:user)

  before do
    login_user(email: user.email, password: 'password')
    expect(page).to have_content('ログインに成功しました')  # ログインが成功したことを確認
  end

  it '新規習慣が正常に作成されること' do
    visit new_habit_path
    expect(page).to have_content('新しい習慣')
    within('form') do
      fill_in '習慣名', with: '毎日の運動'
      choose '継続したい習慣'
      fill_in '説明', with: '健康のために毎日運動する'
    end
    click_button '登録'

    expect(page).to have_content('習慣が正常に作成されました。')
    expect(page).to have_content('毎日の運動')
  end

  it '既存の習慣が正常に編集されること' do
    habit = create(:habit, user: user, name: '毎日の運動')
    visit edit_habit_path(habit)
    expect(page).to have_content('習慣の編集')
    within('form') do
      fill_in '習慣名', with: '毎日の運動'
      choose '継続したい習慣'
      fill_in '説明', with: '健康のために毎日運動する'
    end
    click_button '更新'

    expect(page).to have_content('習慣が正常に更新されました。')
    expect(page).to have_content('健康のために毎日運動する')
  end

  it '習慣が正常に削除されること' do
    habit = create(:habit, user: user, name: '削除する習慣')
    visit habit_path(habit)

    # 確認ダイアログを自動的に「OK」する
    page.accept_confirm '本当に削除しますか？' do
      click_link '削除'
    end

    expect(page).to have_content('習慣が正常に削除されました。')
    expect(page).not_to have_content('削除する習慣')
  end
end
