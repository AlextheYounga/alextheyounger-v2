class BookCategoriesController < ApplicationController
  before_action :restrict
  def index
    @categories = BookCategory.all
  end

  def create
    @category = BookCategory.new(book_category_params)
    if @category.save
      flash[:success] = 'Category was successfully created'
      redirect_to book_categories_path
    else
      render 'new'
    end
  end

  def new
    @category = BookCategory.new
  end

  def edit
    @category = BookCategory.find(params[:id])
  end

  def update
    @category = BookCategory.find(params[:id])
    if @category.update(book_category_params)
      flash[:success] = 'Name was successfully updated'
      redirect_to book_categories_path
    else
      render 'edit'
    end
  end

  private

  def book_category_params
    params.require(:book_category).permit(:name, :html_selector)
  end

  def restrict
    redirect_to root_path unless master_logged_in?
  end
end
