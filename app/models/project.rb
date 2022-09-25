require 'mini_magick'
require 'colorize'

class Project < ActiveRecord::Base
  has_many_attached :screens

  def webp_attachment
    screens.each do |screen|
      type = screen.blob.content_type
      next unless type == 'image/webp'
      return screen.service_url if Rails.env.production?
      return Rails.application.routes.url_helpers.rails_blob_path(screen, only_path: true) if Rails.env.development?
    end
    nil
  end

  def jpeg_attachment
    screens.each do |screen|
      type = screen.blob.content_type
      next unless type == 'image/jpeg'
      return screen.service_url if Rails.env.production?
      return Rails.application.routes.url_helpers.rails_blob_path(screen, only_path: true) if Rails.env.development?
    end
    nil
  end

  def attach_screen(screen)
    return if screen.nil?

    resize_screen(screen)
    webp_obj = WebpConverter.generate_attachment_webp(screen)
    screens.attach(screen)
    screens.attach(io: File.open(webp_obj.first), filename: webp_obj.last, content_type: 'image/webp')
  end

  def seed_screens(img)
    screens.attach(io: File.open("app/assets/images/#{img}"), filename: img, content_type: 'image/jpg')
    webp_blob = ActiveStorage::Blob.create_after_upload!(
      io: File.open("app/assets/images/#{img}.webp"),
      filename: "#{img}.webp", content_type: 'image/webp'
    )
    screens.attach(webp_blob)
    if screens.attached?
      puts "#{title} screens attached".green
      return true
    end

    false
  end

  def reorder_positions
    i = position.clone
    Project.where('position >= ?', i).order(:position).each do |project|
      next if id == project.id

      i += 1
      project.update(position: i)
    end
  end

  def assign_color(attribute)
    colors = {
      'ruby-on-rails' => {
        'text' => 'text-red-600',
        'bg' => 'bg-red-100'
      },
      'php-laravel' => {
        'text' => 'text-blue-600',
        'bg' => 'bg-blue-100'
      },
      'php' => {
        'text' => 'text-blue-600',
        'bg' => 'bg-blue-100'
      },
      'wordpress' => {
        'text' => 'text-blue-700',
        'bg' => 'bg-blue-50'
      },
      'python' => {
        'text' => 'text-yellow-700',
        'bg' => 'bg-yellow-100'
      },
      'net' => {
        'text' => 'text-gray-700',
        'bg' => 'bg-gray-200'
      },
      'electron-js' => {
        'text' => 'text-green-700',
        'bg' => 'bg-green-100'
      }
    }

    lang = framework.parameterize
    colors.dig(lang, attribute).nil? ? '' : colors[lang][attribute]
  end

  private

  def resize_screen(cover)
    mini_image = MiniMagick::Image.new(cover.tempfile.path)
    mini_image.resize "#{mini_image.width}x192"
  end
end
