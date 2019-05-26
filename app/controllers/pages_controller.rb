require 'rubygems'
require 'rss'
require 'stock_quote'

class PagesController < ApplicationController


  def home
    @articles = Article.order("created_at desc").limit(3)
    @books = Book.all
  end

  def about
  end

  def readinglist
    @books = Book.all
  end

  def projects
    @projects = Project.all
  end

  def playground
    @user_stocks = User.last.stocks
    @favorite_quotes = FavoriteQuote.all
    # @quotes = FavoriteQuote.quote
    # @name = FavoriteQuote.name
  end

end



