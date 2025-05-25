module FollowRequestsHelper
  def follow_request_to(user)
    FollowRequest.where(follower_id: current_user.id, user_id: user.id).last
  end
end
