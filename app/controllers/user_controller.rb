class UserController < ApplicationController
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
      File.binwrite("public/users?img/#{@user.img_name}", image.read)
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
end
