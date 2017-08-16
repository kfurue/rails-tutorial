require 'doorkeeper/grape/helpers'

module V1
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: 'integer', desc: 'User ID.', required: true }
      expose :name, documentation: { type: 'string', desc: 'User name.', required: true }
      expose :email, documentation: { type: 'string', desc: 'User email address', required: true }
    end
    
    class Picture < Grape::Entity
      expose :url, documentation: { type: 'string', desc: 'URL of picture.(It will be `null` if there are no picture.)', required: true }
    end

    class Micropost < Grape::Entity
      expose :id, documentation: { type: 'integer', desc: 'Micropost ID.', required: true }
      expose :content, documentation: { type: 'string', desc: 'Micropost content.', required: true }
      expose :user_id, documentation: { type: 'integer', desc: 'User ID of the micropost.', required: true }
      expose :picture, using: Entities::Picture, documentation: { type: Entities::Picture, desc: 'Picture info added to the micropost.', param_type: 'body', required: true }
    end
    
  end

  class Users < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :users do

      desc 'Return all users.', is_array: true,
        entity: Entities::User
      get do
        users = User.all
        present users, with: Entities::User
      end

      desc 'Return user with id.',
        entity: Entities::User
      params do
        requires :id, type: Integer, desc: 'User id.'
      end
      route_param :id do
        get do
          user = User.find(params[:id])
          present user, with: Entities::User
        end
        
        resource :following do
          desc 'Return following users of user with id.', is_array: true,
            entity: Entities::User
          get do
            following = User.find(params[:id]).following
            present following, with: Entities::User
          end
        end
        
        resource :followers do
          desc 'Return followers of user with id.', is_array: true,
            entity: Entities::User
          get do
            followers = User.find(params[:id]).followers
            present followers, with: Entities::User
          end
        end
        
        resource :microposts do
          desc 'Return microposts of user with id.', is_array: true,
            entity: Entities::Micropost
          get do
            microposts = User.find(params[:id]).microposts
            present microposts, with: Entities::Micropost
          end
        end
      end
    end
  end
end