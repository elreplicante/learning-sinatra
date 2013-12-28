# Generated by cucumber-sinatra. (2013-12-28 19:46:07 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'server.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'rack/test'

module AppHelper
  def app
    App
  end
end

World(Rack::Test::Methods, AppHelper)

Capybara.app = App

class AppWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  AppWorld.new
end
