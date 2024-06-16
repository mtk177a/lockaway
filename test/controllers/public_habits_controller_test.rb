require "test_helper"

class PublicHabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_habits_index_url
    assert_response :success
  end
end
