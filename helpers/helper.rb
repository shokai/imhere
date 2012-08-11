
def user_regex
  "[a-zA-Z0-9_]{1,24}"
end

def app_root
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
end
