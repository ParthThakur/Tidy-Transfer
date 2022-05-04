require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "Should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    john = users(:one)
    post login_url, params: {email: john.email, password: 'secret'}
    assert_redirected_to user_url(john)
    assert_equal john.id, session[:user_id]
  end

  test "should fail login" do
    john = users(:one)
    post login_url, params: {name: john.name, password: 'wrong'}
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to login_url
  end
end
