require 'doorkeeper/grape/helpers'

module V1

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