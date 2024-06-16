require "test_helper"

class PublicRewardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_rewards_index_url
    assert_response :success
  end
end
