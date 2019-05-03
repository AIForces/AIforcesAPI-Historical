require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get submissions_index_url
    assert_response :success
  end

  test "should get new" do
    get submissions_new_url
    assert_response :success
  end

  test "should get show" do
    get submissions_show_url
    assert_response :success
  end

end
