require 'grape-swagger'

module V2
  class Root < Grape::API
    version 'v2', using: :path
    format :json
    prefix :api

    mount V2::Users
    add_swagger_documentation
  end
end
