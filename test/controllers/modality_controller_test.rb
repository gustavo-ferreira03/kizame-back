require "test_helper"

class ModalityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get modality_index_url
    assert_response :success
  end

  test "should get create" do
    get modality_create_url
    assert_response :success
  end

  test "should get destroy" do
    get modality_destroy_url
    assert_response :success
  end
end
