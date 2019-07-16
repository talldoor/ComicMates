class UsersController < ApplicationController
  def edit_account
    @user = current_user
  end

  def update_account
    @user = current_user
    if @user.update_without_password(user_account_params)
      redirect_to edit_user_registration_path, notice: 'アカウント情報を変更しました。'
    else
      flash.now.alert = '入力に誤りがあります。'
      render :edit_account
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_password_params)
      bypass_sign_in(@user)
      redirect_to edit_user_registration_path, notice: 'パスワードを変更しました。'
    else
      flash.now.alert = '入力に誤りがあります。'
      render :edit_password
    end
  end

  def show
    @user = current_user
  end

  private

  def user_account_params
    params.require(:user).permit(:name, :email)
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
