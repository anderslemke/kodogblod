 require 'rubygems'
require "nokogiri"
require 'open-uri'
require 'rmagick'

images_root = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'images', 'fotoklub'))

originals_dir = File.join(images_root, 'originals')
big_dir = File.join(images_root, 'big')
small_dir = File.join(images_root, 'small')
thumb_dir = File.join(images_root, 'thumb')

photographers = Dir.entries(originals_dir).select {|entry| !entry.match(/^\./) }

photographers.each do |photographer|
  photographer_dir = File.join(originals_dir, photographer)

  images = Dir.entries(photographer_dir).select {|entry| !entry.match(/^\./) }

  images.each do |image_name|
    image_path = File.join(photographer_dir, image_name)
    image = Magick::Image::read(image_path).first
    thumb = image.resize_to_fill(200, 200)
    small = image.resize_to_fit(500, 500)
    big = image.resize_to_fit(1000, 1000)
    
    filename = "#{photographer}-#{File.basename(image.filename)}"
    thumb.write File.join(thumb_dir, filename)
    small.write File.join(small_dir, filename)
    big.write File.join(big_dir, filename)
  end
end