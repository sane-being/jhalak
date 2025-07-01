class UsersController < ApplicationController
  before_action :set_and_authorize_user, only: %i[ show edit update followers_index following_index ]
  verify_authorized

  def index
    @users = authorized_scope(User.all)
    authorize!
  end

  def followers_index
    @accepted_follow_requests = FollowRequest.where(accepted: true, user: @user)
    authorize!
  end

  def following_index
    @accepted_follow_requests =  FollowRequest.where(accepted: true, follower: @user)
    authorize!
  end

  def show
    @posts = authorized_scope(@user.posts)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_user
      id = ([ "followers_index", "following_index" ].include? action_name) ? :user_id : :id
      @user = User.find(params.expect(id))
      authorize! @user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :profile_picture, :bio, :website, :username ])
    end
end
