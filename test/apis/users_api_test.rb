require "minitest/autorun"

class V1::UsersTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def setup
    @user = users(:michael)
  end

  test 'GET /api/v1/users returns an array of all users' do
    users = User.all
    users_json = users.to_json(only: [:id, :name, :email])
    
    get '/api/v1/users'
    
    assert last_response.ok?
    assert_equal JSON.parse(users_json), JSON.parse(last_response.body)
  end
  
  test 'GET /api/v1/users/1 returns an user' do
    users_json = @user.to_json(only: [:id, :name, :email])

    get "/api/v1/users/#{@user.id}"
    
    assert last_response.ok?
    assert_equal JSON.parse(users_json), JSON.parse(last_response.body)
  end

end
