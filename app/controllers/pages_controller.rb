class PagesController < ApplicationController
  def home
    @projects = Project.order(:position)
    @language_stats = GithubLanguage.calculateWidths
    set_meta_tags title: 'Home',
                  site: 'alextheyounger.me',
                  description: 'Alex Younger - My Space on the Internet',
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg'),
                  og: {
                    title: 'Home',
                    url: Rails.root.to_s,
                    image: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg')
                  },
                  twitter: {
                    card: 'Alex Younger - My Space on the Internet'
                  }
  end

  def resume
    @projects = Project.order(:position)
    @language_stats = GithubLanguage.calculateWidths
    set_meta_tags title: 'Resume',
                  site: 'alextheyounger.me',
                  description: 'Alex Younger - Web Developer, Data Scientist, Investor, Entrepreneur',
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg'),
                  og: {
                    title: 'Home',
                    url: "#{Rails.root}/resume",
                    image: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg')
                  },
                  twitter: {
                    card: 'Alex Younger - Web Developer, Data Scientist, Investor, Entrepreneur'
                  }

    render layout: 'landingpage'
  end
end
