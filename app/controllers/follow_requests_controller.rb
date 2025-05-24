class FollowRequestsController < ApplicationController
  before_action :set_follow_request, only: %i[ show edit update destroy ]

  # GET /follow_requests or /follow_requests.json
  def index
    @follow_requests = FollowRequest.where(user_id: current_user.id).all
  end

  # GET /follow_requests/1 or /follow_requests/1.json
  def show
  end

  # GET /follow_requests/new
  def new
    @follow_request = FollowRequest.new
  end

  # GET /follow_requests/1/edit
  def edit
  end

  # POST /follow_requests or /follow_requests.json
  def create
    @follow_request = FollowRequest.new(follow_request_params)
    @follow_request.follower_id = current_user.id

    respond_to do |format|
      if @follow_request.save
        format.html { redirect_to @follow_request.user, notice: "Follow request was successfully created." }
        format.json { render :show, status: :created, location: @follow_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /follow_requests/1 or /follow_requests/1.json
  def update
    respond_to do |format|
      if @follow_request.update(follow_request_params)
        format.html { redirect_to @follow_request, notice: "Follow request was successfully updated." }
        format.json { render :show, status: :ok, location: @follow_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @follow_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follow_requests/1 or /follow_requests/1.json
  def destroy
    @user = @follow_request.user
    @follow_request.destroy!

    respond_to do |format|
      format.html { redirect_to @user, status: :see_other, notice: "Follow request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow_request
      @follow_request = FollowRequest.find(params.expect(:id))
    end

    # Check user authorization: follower user can only #create or #destroy request
    # followed user can only #edit, #update the request response to accept  
    def authorize_user
      redirect_to root_path, alert: "You are not authorized to access this page" unless @user == current_user
    end

    # Only allow a list of trusted parameters through.
    def follow_request_params
      params.expect(follow_request: [ :accepted, :user_id ])
    end
end
