require 'test_helper'

class ChallengeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get challenge_new_url
    assert_response :success
  end

  test "should get create" do
    get challenge_create_url
    assert_response :success
  end

  test "should get rules" do
    get challenge_show_url
    assert_response :success
  end

  test "should get index" do
    get challenge_index_url
    assert_response :success
  end

end
