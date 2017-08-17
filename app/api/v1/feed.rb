require 'doorkeeper/grape/helpers'

module V1

  class Feed < Grape::API

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    resource :feed do
      desc 'Return feed.', is_array: true,
      entity: Entities::Micropost
      get do
        user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        if user
          userFeed = user.feed
          present userFeed, with: Entities::Micropost
        end
      end
    end
  end
end