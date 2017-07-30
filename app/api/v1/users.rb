require 'doorkeeper/grape/helpers'

module V1
  class Users < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :users do

      desc 'Return all users.'
      get do
        User.all
      end

      desc 'Return a user.'
      params do
        requires :id, type: Integer, desc: 'User id.'
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end
    end
  end
end