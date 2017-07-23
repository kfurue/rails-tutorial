require 'doorkeeper/grape/helpers'

module V2
  class Users < Grape::API
    version 'v2', using: :path
    format :json
    prefix :api
    
    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :users do
      get do
        User.all
      end

      params do
        requires :id, type: Integer, desc: 'Status id.'
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end
    end
  end
end