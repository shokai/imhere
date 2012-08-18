require 'twitter'
require 'oauth'

configure :development do
  set :sessions, true
end

configure :production do
  use Rack::Session::Cookie, {
    :key => 'rack.session',
    :domain => Conf['session_domain'],
    :path => '/',
    :expire_after => 60*60*24*14, # 2 weeks
    :secret => Conf['session_secret']
  }
end

def consumer
  OAuth::Consumer.new(Conf['twitter_consumer_key'],
                      Conf['twitter_consumer_secret'],
                      :site => "http://twitter.com")
end

def auth?
  return true if session[:access_token] and session[:access_token_secret]
  return false
  !!session[:token]
end
