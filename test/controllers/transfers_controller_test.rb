require "test_helper"

class TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transfer = transfers(:one)

    # User needs to be logged in for most of the actiona on transfers controller.
    john = users(:one)
    jane = users(:two)
    post login_url, params: {email: john.email, password: 'secret'}
  end

  test "should get index" do
    get transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_transfer_url
    assert_response :success
  end

  test "should create transfer" do
    assert_difference("Transfer.count") do
      post transfers_path, params: { transfer: { file: fixture_file_upload('test_text_file.txt', 'text/plain'),
                                                 description: @transfer.description, 
                                                 title: @transfer.title, file_type: @transfer.file_type,  } }
    end
    assert_redirected_to user_url(john)
  end

  test "should show transfer" do
    get transfer_url(@transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_transfer_url(@transfer)
    assert_response :success
  end

  test "should update transfer" do
    patch transfer_url(@transfer), params: { transfer: { description: @transfer.description, sharable_link: @transfer.sharable_link, title: @transfer.title, type: @transfer.type, user_id: @transfer.user_id } }
    assert_redirected_to transfer_url(@transfer)
  end

  test "should destroy transfer" do
    assert_difference("Transfer.count", -1) do
      delete transfer_url(@transfer)
    end

    assert_redirected_to transfers_url
  end
end
