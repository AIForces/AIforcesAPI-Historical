require 'test_helper'

class JudgeControllerTest < ActionDispatch::IntegrationTest
  test "should get receive" do
    get judge_receive_url
    assert_response :success
  end

  test "should get send" do
    get judge_send_url
    assert_response :success
  end

end
