class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :find_article, only: [:edit, :update, :destroy]

  def index
    @q = Article.ransack(params[:q])
    if params[:search_btn].blank?
      @articles = Article.none
    else
      @articles = @q.result(distinct: true).recent.page(params[:page])
      if @articles.empty?
        flash.now[:notice] = '該当する記事が見つかりませんでした。'
      end
    end
  end

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
      redirect_to article_path(@article), notice: '記事を投稿しました。'
    else
      flash.now[:alert] = '入力に誤りがあります。'
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '記事を更新しました。'
    else
      flash.now[:alert] = '入力に誤りがあります。'
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, notice: '記事を削除しました。'
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
