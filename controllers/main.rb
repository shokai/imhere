before '/*.json' do
  content_type 'application/json'
end

get Regexp.new "^/u/(#{user_regex})$" do
  name = params['captures'][0]
  @user = User.find_by_name(name) || User.new(:name => name)
  haml :user
end

get Regexp.new "^/u/(#{user_regex}).json$" do
  name = params['captures'][0]
  @user = User.find_by_name name
  halt 404, "User not exists. (\"#{name}\")" unless @user
  @user.to_json
end

post Regexp.new "^/loc/(#{user_regex}).json$" do
  name = params['captures'][0]
  unless params['lat'] and params['lon']
    halt 400, 'Bad Request : params "lat" and "lon" required'
  end
  lat = params['lat'].to_f
  lon = params['lon'].to_f
  @user = User.find_or_create_by_name name
  @user.loc = {:lat => lat, :lon => lon}
  halt 500, 'Save Error' unless @user.save
  @user.to_json
end
