
class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  before_action :hostile_threat
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :master_logged_in?

  $linkedin = 'https://www.linkedin.com/in/alexyounger/'
  $github = 'https://github.com/AlextheYounga'
  $codepen = 'https://codepen.io/alextheyounger/'
  $medium = 'https://medium.com/@AlextheYounger'
  $email = 'alex@alextheyounger.me'

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #the ||= prevents the session from bombing the database with repetitive hits
  end

  def logged_in?
    !!current_user
    # '!!' is the sign for boolean, meaning true or false
  end

  def master_logged_in?
    if (logged_in?)
      if (current_user.role = "master" && current_user.admin_security_key == Rails.application.credentials.admin_security_key)
        return true
      end
      return false
    end
    return false
  end

  def hostile_threat
    if (logged_in?)
      if (current_user.admin_security_key != Rails.application.credentials.admin_security_key)
        flash[:danger] = "Hostile Threat"
        flash[:danger] = "I don't know who you are. I don't know what you want. If you are looking for ransom I can tell you I don't have money, but what I do have are a very particular set of skills. Skills I have acquired over a very long career. Skills that make me a nightmare for people like you. If you leave my website now that'll be the end of it. I will not look for you, I will not pursue you, but if you don't, I will look for you, I will find you... and I will kill you."
        session[:user_id] = nil
      end
    end
  end

end
