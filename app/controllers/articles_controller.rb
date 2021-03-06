class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :restrict

  def index
    #@articles = Article.all
    @articles = Article.order("created_at desc")
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.where(role: "master")
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully obliterated"
    redirect_to articles_path
  end

  private

  def restrict
    if not master_logged_in?
      redirect_to root_path
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :editor1, :description, category_ids: [])
  end
end
