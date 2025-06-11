class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  verify_authorized except: %i[ index show ]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    authorize! @user
  end

  def update
    authorize! @user
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :bio, :website, :username ])
    end
end
