require 'doorkeeper/grape/helpers'

module V1

  class Relationships < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end
    
    resource :relationships do
      desc 'Create relationship between user with followed_id.'
      params do
        requires :followed_id, type: Integer, desc: 'The ID of the user for whom to be followed.'
      end
      post do
        user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        followed_user = User.find(params[:followed_id])
        if user && followed_user
          user.follow(followed_user)
        end
      end

      desc 'Destroy relationship between user with followed_id.'
      params do
        requires :followed_id, type: Integer, desc: 'The ID of the user for whom to be unfollowed.'
      end
      delete do
        user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        unfollowed_user = User.find(params[:followed_id])
        if user && unfollowed_user && user.following?(unfollowed_user)
          user.unfollow(unfollowed_user)
        end
      end
    end
  end
end