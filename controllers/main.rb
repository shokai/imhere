before '/*.json' do
  content_type 'application/json'
end

get Regexp.new "^/u/(#{user_regex})$" do
  name = params['captures'][0]
  @user = User.find_by_name(name) || User.new(:name => name)
  haml :user
end
