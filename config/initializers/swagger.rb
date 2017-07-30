GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc'
GrapeSwaggerRails.options.api_auth     = 'bearer'
GrapeSwaggerRails.options.api_key_name = 'Authorization'
GrapeSwaggerRails.options.api_key_type = 'header'
GrapeSwaggerRails.options.before_action do |request|
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port

  if (user_id = session[:user_id])
    current_user ||= User.find_by(id: user_id)
    if (current_user_token = current_user.token)
      GrapeSwaggerRails.options.api_key_default_value = current_user_token.token
    end
  else
    session[:forwarding_url] = request.fullpath
    redirect_to(GrapeSwaggerRails.options.app_url + '/login')
  end
end
GrapeSwaggerRails.options.hide_url_input = true
