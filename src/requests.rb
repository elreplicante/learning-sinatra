require 'sinatra'

before do
  content_type :txt
end

get '/request' do
  request.env.map { |e| e.to_s + '\n' }
end


get '/request_methods' do
  request.methods.map { |e| e.to_s + '\n' }
end
