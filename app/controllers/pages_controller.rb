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
                    card: "Alex Younger - My Space on the Internet",
                    site: "@AlextheYounga",
                  }
  end
end
