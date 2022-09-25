require 'rails_helper'

RSpec.describe 'PagesControllers', type: :request do
  describe 'GET /' do
    it 'renders the home template' do
      get root_path

      templates = [
        'language_bar/_language_bar',
        'pages/home',
        'layouts/_terrain',
        'partials/_nav',
        'shared/_messages',
        'partials/_footer',
        'layouts/application'
      ]

      templates.each do |template|
        expect(response).to render_template(template)
      end
    end
  end

  describe 'GET /resume' do
    it 'renders the resume template' do
      get resume_path

      templates = ['pages/resume', 'language_bar/_language_bar']

      templates.each do |template|
        expect(response).to render_template(template)
      end
    end
  end
end
