require 'mini_magick'
require 'colorize'

class Book < ActiveRecord::Base
  belongs_to :book_category
  has_many_attached :covers

  def cover_urls
    return unless covers.attachments

    covers.attachments.map do |cover|
      Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true)
    end
  end

  def webp_attachment
    covers.each do |cover|
      type = cover.blob.content_type
      next unless type == 'image/webp'
      return cover.service_url if Rails.env.production?
      return Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true) if Rails.env.development?
    end
    nil
  end

  def jpeg_attachment
    covers.each do |cover|
      type = cover.blob.content_type
      next unless type == 'image/jpeg'
      return cover.service_url if Rails.env.production?
      return Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true) if Rails.env.development?
    end
    nil
  end

  def attach_cover(params)
    cover = params.dig(:book, :cover)
    return if cover.nil?

    resize_cover(cover)
    webp_obj = WebpConverter.generate_attachment_webp(cover)
    covers.attach(cover)
    covers.attach(io: File.open(webp_obj.first), filename: webp_obj.last, content_type: 'image/webp')
  end

  def seed_covers(img)
    covers.attach(io: File.open("app/assets/images/#{img}"), filename: img, content_type: 'image/jpg')
    webp_blob = ActiveStorage::Blob.create_after_upload!(
      io: File.open("app/assets/images/#{img}.webp"),
      filename: "#{img}.webp", content_type: 'image/webp'
    )
    covers.attach(webp_blob)
    if covers.attached?
      puts "#{title} covers attached".green
      return true
    end

    false
  end

  def reorder_positions
    i = position.clone
    Book.where('position >= ?', i).order(:position).each do |book|
      next if id == book.id

      i += 1
      book.update(position: i)
    end
  end

  private

  def resize_cover(cover)
    mini_image = MiniMagick::Image.new(cover.tempfile.path)
    mini_image.resize "200x#{mini_image.height}"
  end
end
