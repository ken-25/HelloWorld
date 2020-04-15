class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id] == nil
      @current_user = nil
    else
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  # ログイン権限処理
   def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
   end
   def ensure_correct_user
     if @current_user.admin? || @current_user.id == params[:id].to_i
       flash[:notice] =""
     else
       flash[:notice] ="権限がありません"
       redirect_to post_index_url
     end
   end
   def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to post_index_url
    end
   end
   def admin_user
     if @current_user.admin?
       flash[:notice] =""
     else
       flash[:notice] ="権限がありません"
       redirect_to post_index_url
     end
   end
end
