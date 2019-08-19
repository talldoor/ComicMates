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
      flash[:alert] = 'コメント入力に誤りがあります。'
      redirect_back(fallback_location: article_path(@article))
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    @article = Article.find(comment.article_id)
    comment.destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_back(fallback_location: article_path(@article))
  end

  private

  def comment_params
    params.permit(:content)
  end
end
