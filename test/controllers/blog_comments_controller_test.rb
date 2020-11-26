require 'test_helper'

class BlogCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get blog_comments_show_url
    assert_response :success
  end
end
