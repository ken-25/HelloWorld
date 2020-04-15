class UserController < ApplicationController
  before_action :authenticate_user, {only:[:edit, :update, :destroy, :edit_password, :update_password, :mg]}
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy, :edit_password, :update_password]}
  before_action :forbid_login_user, {only:[:new, :create, :login_form, :login]}
  before_action :admin_user, {only:[:mg]}

  def index
    @users = User.all.order(created_at: :desc)
  end
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
    @likes = Like.where(user_id: @user.id)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      img_name: "default_user.jpg",
      admin: false,
      body_length: nil,
      giraffe_type: nil,
      place: "サバンナ")
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
    @user.place = params[:place]
    @user.body_length = params[:body_length]
    @user.giraffe_type = params[:giraffe_type]
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

  def edit_password
    @user = User.find_by(id: params[:id])
  end
  def update_password
    @user = User.find_by(id: params[:id])
    if @user.authenticate(params[:old_password])
      if params[:new_password] == params[:confirmation_password]
        @user.password = params[:new_password]
        @user.save
        flash[:notice] ="パスワードを保存しました"
        redirect_to user_index_url
      else
        @error_message ="新しいパスワード(確認用)が一致しません"
        render :edit_password
      end
    else
      @error_message ="パスワードが違います"
      render :edit_password
    end

  end
#管理者のみアクセス可
  def mg
    @users = User.all.order(created_at: :desc)
    @posts = Post.all.order(created_at: :desc)
    @likes = Like.all.order(created_at: :desc)
  end

  # ログイン関連
  def login_form
    @user = User.new
  end
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
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
