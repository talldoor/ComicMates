class TopController < ApplicationController
  def home
    @articles = Article.recent.page(params[:page])

    if user_signed_in?
      @my_articles = current_user.articles.recent.page(params[:page])
      @followers = current_user.followers.recent.page(params[:page])
      @following = current_user.following.recent.page(params[:page])
      get_tab_count(current_user)
    end
  end
end
