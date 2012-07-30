# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'erb'

get '/' do
  erb :index
end