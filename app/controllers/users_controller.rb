class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user,
                only: [:edit_account, :update_account, :edit_password, :update_password]

  def index
    @q = User.ransack(params[:q])
    if params[:all_user].present?
      @users = User.recent.page(params[:page])
    else
      @users = @q.result(distinct: true).recent.page(params[:page])
      if @users.empty?
        flash[:notice] = '該当するユーザーが見つかりませんでした。'
      end
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @user_articles = @user.articles.recent.page(params[:page])
    @liked_articles = @user.liked_articles.recent.page(params[:page])
    @followers = @user.followers.recent.page(params[:page])
    @following = @user.following.recent.page(params[:page])
    get_tab_count(@user)
  end

  def edit_account
  end

  def update_account
    if @user.update_without_password(user_account_params)
      redirect_to edit_user_registration_path, notice: 'アカウント情報を変更しました。'
    else
      flash.now.alert = '入力に誤りがあります。'
      render :edit_account
    end
  end

  def edit_password
  end

  def update_password
    if @user.update_with_password(user_password_params)
      bypass_sign_in(@user)
      redirect_to edit_user_registration_path, notice: 'パスワードを変更しました。'
    else
      flash.now.alert = '入力に誤りがあります。'
      render :edit_password
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_account_params
    params.require(:user).permit(:name, :email)
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
