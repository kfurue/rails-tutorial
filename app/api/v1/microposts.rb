require 'doorkeeper/grape/helpers'

module V1

  class Microposts < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :microposts do
      desc 'Create a new micropost.'
      params do
        requires :content, type: String, desc: 'Your micropost.'
      end
      post do
        user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        if user
          micropost = user.microposts.build(content: params[:content])
          micropost.save
        end
      end
      
      route_param :id do
        desc 'Destroy micropost with id.'
        delete do
          user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
          if user
            micropost = user.microposts.find(params[:id])
            micropost.destroy
          end
        end
      end
    end
  end
end