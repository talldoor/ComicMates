class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @article.like(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @article = Like.find(params[:id]).article
    @article.unlike(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
