class PostsController < ApplicationController
  before_action :set_and_authorize_post, only: %i[ show edit update destroy ]
  verify_authorized

  def index
    @posts = authorized(Post.all)
    authorize!
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.new
    authorize! @post
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize! @post

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_post
      @post = Post.find(params.expect(:id))
      authorize! @post
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :content ])
    end
end
