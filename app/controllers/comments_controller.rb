class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_post

  def index
    @comments = @post.comments
    # authorize! @comments
  end

  def show
  end

  def new
    @comment = @post.comments.new
    @comment.user = current_user
  end

  def edit
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_comment_path(@post, @comment), notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_comment_path(@post, @comment), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_to post_comments_path(@post), status: :see_other, notice: "Comment was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
      # authorize! @comment
    end

    def set_post
      @post = Post.find(params.expect(:post_id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content ])
    end
end
