class FollowRequestsController < ApplicationController
  before_action :set_follow_request, only: %i[ update destroy ]

  # GET /follow_requests or /follow_requests.json
  def index
    @follow_requests = FollowRequest.where(user_id: current_user.id, accepted: false).all
    @accepted_follow_requests = FollowRequest.where(user_id: current_user.id, accepted: true).all
  end

  # POST /follow_requests or /follow_requests.json
  def create
    @follow_request = FollowRequest.new(follow_request_params)
    @follow_request.follower_id = current_user.id
    if @follow_request.save
      redirect_back(fallback_location: root_path, notice: "Follow request was successfully sent.")
    else
      redirect_back(fallback_location: root_path, alert: "Follow request could not be sent.")
    end
  end

  # PATCH/PUT /follow_requests/1 or /follow_requests/1.json
  def update
    # Check user authorization
    unless @follow_request.user == current_user
      redirect_to root_path, alert: "You are not authorized to update/destroy this follow request"
    end
    
    if @follow_request.update(follow_request_params)
      redirect_back(fallback_location: root_path, notice: "Follow request was accepted.")
    else
      redirect_back(fallback_location: root_path, alert: "Follow request could not be accepted.")
    end
  end

  # DELETE /follow_requests/1 or /follow_requests/1.json
  def destroy
    # Check user authorization
    unless [@follow_request.follower, @follow_request.user].include? current_user
      redirect_to root_path, alert: "You are not authorized to update/destroy this follow request"
    end
    
    @follow_request.destroy!
    redirect_back(fallback_location: root_path, notice: "Follow request was successfully deleted.")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow_request
      @follow_request = FollowRequest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def follow_request_params
      params.expect(follow_request: [ :user_id ])
    end
end
