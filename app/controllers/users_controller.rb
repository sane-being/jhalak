class UsersController < ApplicationController
  before_action :set_and_authorize_user, only: %i[ show edit update ]
  verify_authorized

  def index
    @users = authorized(User.all)
    authorize!
  end

  def show
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
      @user = User.find(params.expect(:id))
      authorize! @user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :profile_picture, :bio, :website, :username ])
    end
end
