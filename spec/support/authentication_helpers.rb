module AuthenticationHelpers
  def login_user(email:, password:)
    visit login_path
    fill_in 'メールアドレス', with: email
    fill_in 'パスワード', with: password
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :system
end
