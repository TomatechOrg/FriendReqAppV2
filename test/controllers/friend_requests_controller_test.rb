require "test_helper"

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in users(:bob)
    get friend_requests_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:bob)
    get new_friend_request_url
    assert_response :success
  end

  test "should create friend_request" do
    sign_in users(:bob)
    assert_difference("FriendRequest.count") do
      post friend_requests_url, params: { friend_request: { receiver_id: users(:phil).id } }
    end

    assert_redirected_to friend_requests_url
  end

  test "should not create friend_request because same user" do
    sign_in users(:bob)
    assert_no_difference("FriendRequest.count") do
      post friend_requests_url, params: { friend_request: { receiver_id: users(:bob).id } }
    end

    assert_redirected_to new_friend_request_url
  end

  test "should cancel friend_request" do
    sign_in users(:phil)

    assert_difference("FriendRequest.count", -1) do
      delete friend_request_url(friend_requests(:philToTim))
    end

    assert_redirected_to friend_requests_url
  end

  test "should deny friend_request" do
    sign_in users(:bob)

    assert_difference("FriendRequest.count", -1) do
      delete friend_request_url(friend_requests(:timToBob))
    end

    assert_redirected_to friend_requests_url
  end

  test "should not cancel or deny friend_request because user not invvolved" do
    sign_in users(:phil)

    assert_no_difference("FriendRequest.count") do
      delete friend_request_url(friend_requests(:bobToAdam))
    end
  end
end
