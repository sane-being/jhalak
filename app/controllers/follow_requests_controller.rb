class FollowRequestsController < ApplicationController
  before_action :set_and_authorize_follow_request, only: %i[ update destroy ]
  verify_authorized

  def index
    @follow_requests = authorized(FollowRequest.where(accepted: false))
    @accepted_follow_requests = authorized(FollowRequest.where(accepted: true))
    authorize!
  end

  def create
    @follow_request = FollowRequest.new(params.expect(follow_request: [ :user_id ]))
    @follow_request.follower = current_user
    authorize! @follow_request
    if @follow_request.save
      redirect_back(fallback_location: root_path, notice: "Follow request was successfully sent.")
    else
      redirect_back(fallback_location: root_path, alert: "Follow request could not be sent.")
    end
  end

  def update
    if @follow_request.update(params.expect(follow_request: [ :accepted ]))
      redirect_back(fallback_location: root_path, notice: "Follow request was accepted.")
    else
      redirect_back(fallback_location: root_path, alert: "Follow request could not be accepted.")
    end
  end

  def destroy
    @follow_request.destroy!
    redirect_back(fallback_location: root_path, notice: "Follow request was successfully deleted.")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_follow_request
      @follow_request = FollowRequest.find(params.expect(:id))
      authorize! @follow_request
    end
end
