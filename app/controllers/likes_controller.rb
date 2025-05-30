class LikesController < ApplicationController
  # GET /likes or /likes.json
  def index
    @post = Post.find(params.expect(:post_id))
    @likes = @post.likes
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(user: current_user, post_id: params.expect(:post_id))

    if @like.save
      redirect_back(fallback_location: root_path, notice: "Post was liked")
    else
      redirect_back(fallback_location: root_path, alert: "Post could not be liked")
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like = Like.find(params.expect(:id))
    @like.destroy!

    redirect_back(fallback_location: root_path, notice: "Like removed from the post")
  end
end
