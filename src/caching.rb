require 'sinatra'
require 'uuid'

before do
  content_type :txt
  @guid = UUID.new.generate
end

get '/caching' do
  expires 3600, :public, :must_revalidate
    "This page rendered at #{Time.now}"
end

get '/etag' do
  etag @guid
  "This resource has an ETag value of #{@guid}"
end