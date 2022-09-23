require 'rails_helper'

RSpec.describe 'BooksController', type: :request do
  describe 'GET /books' do
    it 'renders the books index template' do
      get books_path

      templates = [
        'books/index',
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
end
