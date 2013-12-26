require 'sinatra'
require 'uuid'

before do
  content_type :txt
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @defeat.keys
  @guid = UUID.new.generate
end

get '/throw/:type' do
  player_throw = params[:type].to_sym

  if !@throws.include?(player_throw)
    halt 403, "You must throw one of the following  #{@throws}"
  end

  computer_throw = @throws.sample

  if player_throw == computer_throw
    "You tied with the computer.  Try again!"
  elsif computer_throw == @defeat[player_throw]
      "You win!"
  else
    "You lose!"
  end
end

get '/request' do
  request.env.map { |e| e.to_s + '\n'  }
end


get '/request_methods' do
  request.methods.map { |e| e.to_s + '\n'  }
end

get '/caching' do
  expires 3600, :public, :must_revalidate
    "This page rendered at #{Time.now}"
end

get '/etag' do
  etag @guid
  "This resource has an ETag value of #{@guid}"
end