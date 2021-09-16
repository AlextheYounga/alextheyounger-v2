require "iex-ruby-client"
class PagesController < ApplicationController
  def home
    @projects = Project.order(:position)
    @stocks = Stock.all
    @languageStats = GithubLanguage.calculateWidths

    set_meta_tags title: "Home",
                  site: "alextheyounger.me",
                  description: "Alex Younger - My Space on the Internet",
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path("hammock-art.jpg"),
                  og: {
                    title: "Home",
                    url: "#{Rails.root}",
                    image: ActionController::Base.helpers.asset_path("hammock-art.jpg"),
                  },
                  twitter: {
                    card: "Alex Younger - My Space on the Internet"
                  }
  end

  def resume    
    @projects = Project.order(:position)
    @languageStats = GithubLanguage.calculateWidths
    @chartData = Stock.getHistoricalData('TSLA', '3m', false, true)
    set_meta_tags title: "Resume",
                  site: "alextheyounger.me",
                  description: "Alex Younger - Web Developer, Data Scientist, Investor, Entrepreneur",
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path("headshot_square.jpg"),
                  og: {
                    title: "Home",
                    url: "#{Rails.root}/resume",
                    image: ActionController::Base.helpers.asset_path("headshot_square.jpg"),
                  },
                  twitter: {
                    card: "Alex Younger - Web Developer, Data Scientist, Investor, Entrepreneur",                    
                  }
                  
    render layout: "landingpage"
  end
end
