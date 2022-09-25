load 'app/modules/webp_converter.rb'
require 'mini_magick'

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[edit update destroy]
  before_action :restrict, except: :index

  def index
    @projects = Project.order(:position)
    @language_stats = GithubLanguage.calculateWidths
    set_meta_tags title: 'Projects',
                  site: 'alextheyounger.me',
                  description: 'Alex Younger - My projects. Some of my greatest projects',
                  reverse: true,
                  image_src: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg'),
                  og: {
                    title: 'Projects',
                    url: "#{Rails.root}projects",
                    image: ActionController::Base.helpers.asset_path('bridge-standing-opt.jpg')
                  },
                  twitter: {
                    card: 'Alex Younger - Projects. Some of my greatest projects',
                    site: '@AlextheYounga'
                  }
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    @project.image_address = params[:project][:screen].original_filename.to_s if params[:project][:screen]
    @project.image_alt = "Alex Younger Projects List #{params[:project][:title]} in #{params[:project][:framework]}"

    if @project.save
      @project.attach_screen(params)
      @project.reorder_positions
      flash[:notice] = 'Project was successfully created'
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      @project.reorder_positions
      if params[:project][:screen]
        @project.screens.purge
        @project.attach_screen(params)
      end
      flash[:notice] = 'Project was successfully updated'
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = 'Project was successfully obliterated'
    redirect_to projects_path
  end

  private

  def restrict
    redirect_to root_path unless master_logged_in?
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :excerpt,
      :image_address,
      :image_url,
      :image_alt,
      :project_link,
      :framework,
      :position
    )
  end
end
