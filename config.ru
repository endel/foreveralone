# encoding: utf-8

require 'sinatra'

set :run, false
set :root_path, File.dirname(__FILE__)
set :static, '/public'

require "#{settings.root_path}/app.rb"
run Sinatra::Application