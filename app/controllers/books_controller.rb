load "app/modules/webp_converter.rb"
require "mini_magick"

class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]
  before_action :restrict, except: :index

  def index
    @books = Book.order(:position)
	@categories = BookCategory.order(:name)

    set_meta_tags title: "Reading List",
                  site: "alextheyounger.me",
                  description: "Alex Younger - My Reading List. A list of books that have impacted my life in some way.",
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path("books_meta.png"),
                  og: {
                    title: "Reading List",
                    url: "#{Rails.root}",
                    image: ActionController::Base.helpers.asset_path("books_meta.png"),
                  },
                  twitter: {
                    card: "Alex Younger - ReadlingList - Books that have impacted my life in some way.",
                    site: "@AlextheYounga",
                  }
  end

  def reorder
    @books = Book.order(:position)
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.image_address = params[:book][:cover].original_filename.to_s
    @book.image_alt = "Alex Younger Readling List #{params[:book][:title]} by #{params[:book][:author]}"
    if (@book.save)
      @book.attach_covers(params)
      @book.reorder_positions
      flash[:notice] = "Book was successfully created"
      redirect_to books_path
    else
      render "new"
    end    
  end

  def update
    if (@book.update(book_params))
      @book.reorder_positions
      if (params[:book][:cover])
        @book.covers.purge
        @book.attach_covers(params)
      end
      flash[:notice] = "Book was successfully updated"
      redirect_to books_path
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book was successfully obliterated"
    redirect_to books_path
  end

  private

  def restrict
    if not master_logged_in?
      redirect_to root_path
    end
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title,
      :subtitle,
      :book_category_id,
      :image_address,
      :book_link,
      :image_alt,
      :author,
      :position
    )
  end
end
