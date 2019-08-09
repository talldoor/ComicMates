class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [
      :email, :name, :password, :password_confirmation,
    ]
    updated_attrs = [
      :my_book1, :my_book2, :my_book3, :self_introduction,
      :new_profile_image, :remove_profile_image,
    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: updated_attrs)
  end

  private

  def get_tab_count(user)
    @articles_count = Article.count
    @user_articles_count = user.articles.count
    @followers_count = user.followers.count
    @following_count = user.following.count
  end
end
