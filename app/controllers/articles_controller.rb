class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles
  end

  def show
    @article = current_user.articles.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = current_user.articles.find(params[:id])
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
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = '記事を更新しました。'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    flash[:notice] = "記事を削除しました。"
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:comic_title, :comic_author,
                                    :overview, :detail, :image)
  end
end
