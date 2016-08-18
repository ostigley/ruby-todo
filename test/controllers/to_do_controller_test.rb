require 'test_helper'

class ToDoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get to_do_index_url
    assert_response :success
  end

end
