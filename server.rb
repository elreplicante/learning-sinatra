require 'sinatra/base'
require 'uuid'
require 'json'

class App < Sinatra::Base
  set :data, ""
  configure do
    enable :sessions
  end

  before do
    content_type :txt
    @defeat = { rock: :scissors, paper: :rock, scissors: :paper }
    @throws = @defeat.keys
    @guid = UUID.new.generate
  end
  
  get '/attachment' do
    attachment 'assets/example.txt'
    "Sending attachment"
  end

  get '/caching' do
    expires 3600, :public, :must_revalidate
    "This page rendered at #{Time.now}"
  end

  get '/etag' do
    etag @guid
    "This resource has an ETag value of #{@guid}"
  end

  get '/' do
    response.set_cookie "foo", "bar"
    "un mundo tecnologico"
  end

  get '/read' do
    "Cookie was set with a value of #{request.cookies['foo']}."
  end

  get '/delete' do
    response.delete_cookie "foo"
    "Cookie deleted"
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
    request.env.map { |e| e.to_s + '\n' }
  end


  get '/request_methods' do
    request.methods.map { |e| e.to_s + '\n' }
  end

  get '/set' do
    session[:foo] = Time.now
    "Session value set"
  end

  get '/fetch' do
    "Session value #{session[:foo]}"
  end

  get '/logout' do
    session.clear
    redirect '/fetch'
  end

  connections = []

  get '/consume' do
    stream(:keep_open) do |out|
      connections << out

      out.callback { connections.delete(out) }

      out.errback do
        logger.warm 'Connection lost'
        connections.delete(out)
      end
    end
  end

  get '/broadcast/:message' do
    connections.each do |out|
      out << "#{Time.now} -> #{params[:message]}" << "\n"
    end

    "Sent #{params[:message]} to all clients"
  end

  get '/songs' do
    content_type :json
    App.data.to_json
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
