require 'sinatra'
get '/' do
  response.set_cookie "foo", "bar"
  "Cookie set. Do you want to <a href='/read'>read it?</a>"
end

get '/read' do
  "Cookie was set with a value of #{request.cookies['foo']}."
end

get '/delete' do
  response.delete_cookie "foo"
  "Cookie deleted"
end