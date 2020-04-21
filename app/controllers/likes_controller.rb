class LikesController < ApplicationController
  # before_action :set_post

  def update
    @post = Post.find(params[:id])
    @like = @current_user.likes.build(post_id: params[:id])
    @like.save
    # redirect_back(fallback_location: posts_url)
  end
  def destroy
    @post = Post.find(params[:id])
    @like = Like.find_by(
      post_id: params[:id],
      user_id: @current_user.id)
    @like.destroy
    # redirect_back(fallback_location: posts_url)
  end

 #  private
 #  def set_post
 #   @post = Post.find(params[:post_id])
 # end
end
