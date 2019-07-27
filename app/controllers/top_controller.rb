class TopController < ApplicationController
  def home
    @articles = Article.recent.page(params[:page])

    if user_signed_in?
      @my_articles = current_user.articles.recent.page(params[:page])
    end
  end
end
