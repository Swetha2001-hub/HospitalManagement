require "test_helper"

class AdminPatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_patients_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_patients_show_url
    assert_response :success
  end
end
