#!/usr/bin/env ruby

require 'yaml'
require 'pp'
require 'mechanize'

BASE_DIR = File.expand_path(File.dirname(__FILE__))
SETTINGS = YAML.load_file("#{BASE_DIR}/settings.yml")

# invalid emotion shortcut on hipchat
RENAME_MAP = {
  '+1'   => 'plus1',
  '-1'   => 'minus1',
}

agent = Mechanize.new

signin_page          = agent.get(SETTINGS['hipchat']['emotions_url'])
signin_form          = signin_page.form('signin')
signin_form.email    = SETTINGS['hipchat']['email']
signin_form.password = SETTINGS['hipchat']['password']

emotions_page = agent.submit(signin_form, signin_form.buttons.first)


Dir::glob("#{BASE_DIR}/tmp/*.png").each { |file|
  basename      = File.basename(file, ".png")

  basename.gsub!(/(-|_)/, "")
  shortcut_text = RENAME_MAP[basename] || basename

  upload_form = emotions_page.form_with(action: SETTINGS['hipchat']['emotions_url'])
  upload_form.shortcut = shortcut_text
  upload_form.file_uploads.first.file_name = file

  puts "upload: (#{shortcut_text})"

  emotions_page = agent.submit(upload_form, upload_form.buttons.first)
}

