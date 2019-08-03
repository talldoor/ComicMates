class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_article, only: [:edit, :update, :destroy]

  def show
    @article = Article.find_by(id: params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:notice] = '記事を投稿しました。'
      redirect_to article_path(@article)
    else
      # ↓テストロジック
      flash.now.alert = '入力に誤りがあります。'
      # ↑
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = '記事を更新しました。'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "記事を削除しました。"
    redirect_to root_path
  end

  private

  def find_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:comic_title, :comic_author,
                                    :overview, :detail, :new_comic_image, :remove_comic_image)
  end
end
