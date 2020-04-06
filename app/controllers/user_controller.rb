class UserController < ApplicationController
  before_action :authenticate_user, {only:[:edit, :update]}
  before_action :ensure_correct_user, {only:[:edit, :update]}
  before_action :forbid_login_user, {only:[:new, :create, :login_form, :login]}

  def index
    @users = User.all.order(created_at: :desc)
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      img_name: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_index_url
    else
      render :new
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.img_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/users_img/#{@user.img_name}", image.read)
    end
    if @user.save
      redirect_to user_index_url
    else
      render :edit
    end
  end
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to user_index_url
  end

#
  def mg
    @users = User.all.order(created_at: :desc)
    @posts = Post.all.order(created_at: :desc)
  end

  # ログイン関連
  def login_form
    @user = User.new
  end
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to post_index_url
    else
      @error_message = "メールアドレスまはたパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render :login_form
    end
  end
  def logout
    session[:user_id] = nil
    render :login_form
  end

end
