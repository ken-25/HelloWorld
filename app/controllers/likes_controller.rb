class LikesController < ApplicationController
  def update
    @like = Like.new(
      user_id: @current_user.id,
      post_id: params[:id])
    @like.save
    redirect_back(fallback_location: posts_url)
  end
  def destroy
    @like = Like.find_by(
      post_id: params[:id],
      user_id: @current_user.id)
    @like.destroy
    redirect_back(fallback_location: posts_url)
  end
end
