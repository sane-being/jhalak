require "application_system_test_case"

class FollowRequestsTest < ApplicationSystemTestCase
  setup do
    @follow_request = follow_requests(:one)
  end

  test "visiting the index" do
    visit follow_requests_url
    assert_selector "h1", text: "Follow requests"
  end

  test "should create follow request" do
    visit follow_requests_url
    click_on "New follow request"

    check "Accepted" if @follow_request.accepted
    fill_in "Follower", with: @follow_request.follower_id
    fill_in "User", with: @follow_request.user_id
    click_on "Create Follow request"

    assert_text "Follow request was successfully created"
    click_on "Back"
  end

  test "should update Follow request" do
    visit follow_request_url(@follow_request)
    click_on "Edit this follow request", match: :first

    check "Accepted" if @follow_request.accepted
    fill_in "Follower", with: @follow_request.follower_id
    fill_in "User", with: @follow_request.user_id
    click_on "Update Follow request"

    assert_text "Follow request was successfully updated"
    click_on "Back"
  end

  test "should destroy Follow request" do
    visit follow_request_url(@follow_request)
    click_on "Destroy this follow request", match: :first

    assert_text "Follow request was successfully destroyed"
  end
end
