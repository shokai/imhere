
get '/login' do
  request_token = consumer.get_request_token(:oauth_callback => "#{app_root}/login/auth")
  session[:twitter_request_token] = request_token.token
  session[:twitter_request_token_secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/login/auth' do
  request_token = OAuth::RequestToken.new(consumer,
                                          session[:twitter_request_token],
                                          session[:twitter_request_token_secret])
  access_token = request_token.get_access_token({},
                                                :oauth_token => params[:oauth_token],
                                                :oauth_verifier => params[:oauth_verifier])
  Twitter.configure do |config|
    config.consumer_key = Conf['twitter_consumer_key']
    config.consumer_secret = Conf['twitter_consumer_secret']
    config.oauth_token = access_token.token
    config.oauth_token_secret = access_token.secret
  end
  user = Twitter.user
  @user = User.find_or_create_by_id user.id
  @user.name = user.screen_name
  @user.icon_url = user.profile_image_url
  @user.twitter = {
    :oauth_token => access_token.token,
    :oauth_token_secret => access_token.secret
  }
  @user.token = session[:token] = Digest::MD5.hexdigest("#{access_token.token}_#{access_token.secret}_#{Time.now.to_i}")
  @user.save
  session.keys.each do |k|
    session.delete k if k =~ /^twitter_/
  end
  redirect app_root
end

get '/logout' do
  session.delete :token
  redirect app_root
end
