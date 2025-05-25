class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :check_user_authorization, only: %i[ edit update ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
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

    # Check user authorization
    def check_user_authorization
      unless @user == current_user
        redirect_to root_path, alert: "You are not authorized to access this page"
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :bio, :website, :username ])
    end
end
