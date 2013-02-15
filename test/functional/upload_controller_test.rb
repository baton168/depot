require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get get" do
    get :get
    assert_response :success
  end

  test "should get save_picture" do
    get :save_picture
    assert_response :success
  end

end
