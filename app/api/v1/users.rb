require 'doorkeeper/grape/helpers'

module V1
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: 'integer', desc: 'User ID.', required: true }
      expose :name, documentation: { type: 'string', desc: 'User name.', required: true }
      expose :email, documentation: { type: 'string', desc: 'User email address', required: true }
    end

  end

  class Users < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :users do

      desc 'Return all users.',
        entity: Entities::User
      get do
        user = User.all
        present user, with: Entities::User
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