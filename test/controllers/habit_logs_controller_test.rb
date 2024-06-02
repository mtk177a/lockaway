require "test_helper"

class HabitLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get habit_logs_new_url
    assert_response :success
  end

  test "should get create" do
    get habit_logs_create_url
    assert_response :success
  end
end
