require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:jane)
    @john = users(:john)

    sign_in @user
    post user_session_path

  end

  test "should get index" do
    # Getting a list of all users should be prohibited
    get users_url

    assert_redirected_to user_url(@user)
  end

  test "get other user profile" do
    # Accessing ids of other users redirects to current user.
    get user_url(@john)

    assert_redirected_to user_url(@user)
  end

  test "should create user" do
    # Logout setup user first.
    delete destroy_user_session_path

    assert_difference("User.count") do
      post user_registration_path, params: { user: { email: 'new.user@example.org', password: "secret", password_confirmation: "secret" } }
    end

    assert_redirected_to authenticated_root_path
  end

  test "should user logout" do
    delete destroy_user_session_path

    assert_redirected_to unauthenticated_root_path
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_registration_path
    end

    assert_redirected_to unauthenticated_root_path
  end
end
