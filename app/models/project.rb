require "mini_magick"
require "colorize"

class Project < ActiveRecord::Base
  has_many_attached :screens

  def get_webp_attachment
    self.screens.each do |screen|
      type = screen.blob.content_type
      if (type == "image/webp")
        if (Rails.env.production?)
          return screen.service_url
        end
        if (Rails.env.development?)
          return Rails.application.routes.url_helpers.rails_blob_path(screen, only_path: true)
        end
      end
    end
    return false
  end

  def get_jpeg_attachment
    self.screens.each do |screen|
      type = screen.blob.content_type
      if (type == "image/jpeg")
        if (Rails.env.production?)
          return screen.service_url
        end
        if (Rails.env.development?)
          return Rails.application.routes.url_helpers.rails_blob_path(screen, only_path: true)
        end
      end
    end
    return false
  end

  def attach_screens(params)
    if (params[:project][:screen].present?)
      webpObj = WebpConverter.generate_attachment_webp(params[:project][:screen])
      self.screens.attach(params[:project][:screen])
      self.screens.attach(io: File.open(webpObj.first), filename: webpObj.last, content_type: "image/webp")
      if (self.screens.attached?)
        puts "#{self.title} screens attached".green
        return true
      end

      return false
    end
  end

  def update_screens(params)
    if (params.present?)
      webpObj = WebpConverter.generate_attachment_webp(params[:project][:screen])
      self.screens.attach(params[:project][:screen])
      self.screens.attach(io: File.open(webpObj.first), filename: webpObj.last, content_type: "image/webp")
      if (self.screens.attached?)
        puts "#{self.title} screens attached".green
        return true
      end

      return false
    end
  end

  def seed_screens(img)
    if (img.present?)
      self.screens.attach(io: File.open("app/assets/images/#{img}"), filename: img, content_type: "image/jpg")
      webpBlob = ActiveStorage::Blob.create_after_upload!(io: File.open("app/assets/images/#{img}.webp"), filename: "#{img}.webp", content_type: "image/webp")
      self.screens.attach(webpBlob)
      if (self.screens.attached?)
        puts "#{self.title} screens attached".green
        return true
      end

      return false
    end
  end

  def reorder_positions
    i = self.position.clone
    Project.where("position >= ?", i).order(:position).each do |project|
      next if (self.id == project.id)
      i += 1
      project.update(position: i)
    end
  end

  def assign_color
    colors = {
      "ruby-on-rails" => "text-red-600",
      "php-laravel" => "text-blue-600",
      "php" => "text-blue-600",
      "wordpress" => "text-blue-700",
      "python" => "text-yellow-700",
      "net" => "text-gray-700",
    }

    lang = self.framework.parameterize

    return colors[lang]
  end
end
