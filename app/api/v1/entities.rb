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
end