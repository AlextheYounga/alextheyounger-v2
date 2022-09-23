require 'rails_helper'

RSpec.describe 'ProjectsControllers', type: :request do
  describe 'GET /projects' do
    it 'renders the projects template' do
      get projects_path

      templates = [
        'projects/index',
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
