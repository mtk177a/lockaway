require "test_helper"

class UserRewardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_rewards_index_url
    assert_response :success
  end
end
