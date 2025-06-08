class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_comment_path(@post, @comment), notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params.expect(:id))
    # authorize! @comment
    @comment.destroy!
    redirect_to post_comments_path(@post), status: :see_other, notice: "Comment was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find(params.expect(:post_id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content ])
    end
end
