require "test_helper"

class PracticeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get practice_create_url
    assert_response :success
  end

  test "should get verify_qr_code" do
    get practice_verify_qr_code_url
    assert_response :success
  end
end
