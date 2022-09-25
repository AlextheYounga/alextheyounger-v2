require 'rubygems'
require 'webp-ffi'

module WebpConverter
  class << self
    def convert_assets
      image_types = /\.(?:png|jpe?g)$/

      public_assets = File.join(
        Rails.root.join('app', 'assets', 'images')
      )

      Dir["#{public_assets}/**/*"].each do |filename|
        next unless filename =~ image_types

        mtime = File.mtime(filename)
        webp_file = "#{filename}.webp"
        next if File.exist?(webp_file) && File.mtime(webp_file) >= mtime

        begin
          WebP.encode(filename, webp_file, quality: 80)
          File.utime(mtime, mtime, webp_file)
          puts "Webp converted image #{webp_file}"
        rescue StandardError => e
          puts "Webp convertion error of image #{webp_file}. Error info: #{e.message}"
        end
      end
    end

    def generate_attachment_webp(param_attachment)
      filepath = param_attachment.tempfile.path
      webp_path = "#{filepath}.webp"
      webp_filename = "#{param_attachment.original_filename}.webp"
      mtime = File.mtime(filepath)

      begin
        WebP.encode(filepath, webp_path, quality: 80)
        File.utime(mtime, mtime, webp_path)
        puts "Webp converted image #{webp_filename}"
      rescue StandardError => e
        puts "Webp convertion error of image #{webp_filename}. Error info: #{e.message}"
      end

      [webp_path, webp_filename]
    end
  end
end
