require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest
  test 'unauthorized user will be redirected to login page' do
    get root_url 
    assert_redirected_to controller: :sessions, action: :new
end

   test 'user with incorrect credentials will be redirected to login page' do
    post sessions_create_url, params: { log: Faker::Lorem.word, password: Faker::Lorem.word }
     assert_redirected_to controller: :sessions, action: :new
   end
    

    test 'user will see the root after signing up' do
      username = Faker::Lorem.word
      password = Faker::Lorem.word

      post users_url, params: { user: { log: username, password: password, password_confirmation: password } }

      assert_redirected_to user_url(User.last)
    end

    test 'user can destroy' do
      password = Faker::Lorem.word

      user = User.create(log: Faker::Lorem.word, password: password, password_confirmation: password)

      post sessions_create_url, params: { log: user.username, pas: password }

      get sessions_destroy_url

      assert_redirected_to controller: :sessions, action: :new
    end
end