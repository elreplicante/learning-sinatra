require 'sinatra'

before do 
  content_type :txt
end

get '/attachment' do
  attachment 'example.txt'
  "Sending attachment"
end