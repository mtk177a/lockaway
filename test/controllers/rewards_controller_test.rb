require "test_helper"

class RewardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rewards_index_url
    assert_response :success
  end

  test "should get show" do
    get rewards_show_url
    assert_response :success
  end
end
