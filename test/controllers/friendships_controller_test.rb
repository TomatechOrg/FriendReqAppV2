require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @friendship = friendships(:one)
  end

  test "should get index" do
    get friendships_url
    assert_response :success
  end

  test "should get new" do
    get new_friendship_url
    assert_response :success
  end

  test "should create friendship" do
    assert_difference("Friendship.count") do
      post friendships_url, params: { friendship: { primary_friend_id: @friendship.primary_friend_id, secondary_friend_id: @friendship.secondary_friend_id } }
    end

    assert_redirected_to friendship_url(Friendship.last)
  end

  test "should show friendship" do
    get friendship_url(@friendship)
    assert_response :success
  end

  test "should get edit" do
    get edit_friendship_url(@friendship)
    assert_response :success
  end

  test "should update friendship" do
    patch friendship_url(@friendship), params: { friendship: { primary_friend_id: @friendship.primary_friend_id, secondary_friend_id: @friendship.secondary_friend_id } }
    assert_redirected_to friendship_url(@friendship)
  end

  test "should destroy friendship" do
    assert_difference("Friendship.count", -1) do
      delete friendship_url(@friendship)
    end

    assert_redirected_to friendships_url
  end
end
