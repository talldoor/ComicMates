class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    comment = @article.comments.build(comment_params)
    comment.user = current_user
    if comment.save
      flash[:notice] = 'コメントしました。'
      redirect_back(fallback_location: article_path(@article))
    else
      render 'articles/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    @article = Article.find(comment.article_id)
    comment.destroy
    redirect_back(fallback_location: article_path(@article))
  end

  private

  def comment_params
    params.permit(:content)
  end
end
