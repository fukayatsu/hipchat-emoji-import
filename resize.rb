#!/usr/bin/env ruby
require 'mini_magick'

BASE_DIR = File.expand_path(File.dirname(__FILE__))

FileUtils::mkdir_p("#{BASE_DIR}/tmp")
Dir::glob("#{BASE_DIR}/emojis/*.png").each { |file|
  filename = File.basename(file)

  image = MiniMagick::Image.open(file)
  image.resize "25x25"
  image.write  "#{BASE_DIR}/tmp/#{filename}"

  puts "output: #{filename}"
}