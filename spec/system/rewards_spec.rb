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
end
