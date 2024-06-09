require "test_helper"

class UnloggedHabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unlogged_habits_index_url
    assert_response :success
  end
end
