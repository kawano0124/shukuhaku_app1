require "test_helper"

class ShukuhakuControllerTest < ActionDispatch::IntegrationTest
  test "should get yoyaku" do
    get shukuhaku_yoyaku_url
    assert_response :success
  end
end
