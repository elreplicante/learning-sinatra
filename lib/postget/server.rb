require 'sinatra'
require_relative 'post_get'

post_get '/' do
  "hi #{params[:name]}"
end