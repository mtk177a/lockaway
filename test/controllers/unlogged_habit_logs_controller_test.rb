require "test_helper"

class UnloggedHabitLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unlogged_habit_logs_index_url
    assert_response :success
  end
end
