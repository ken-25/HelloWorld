class PostController < ApplicationController
  before_action :authenticate_user, {only:[:edit, :update]}
  before_action :ensure_correct_user, {only:[:edit, :update]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id)
    if @post.save
      redirect_to post_index_url
    else
      render :new
    end
  end
  def edit
    @post = Post.find_by(id: params[:id])
  end
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to post_index_url
    else
      render :edit
    end
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to post_index_url
  end

end
