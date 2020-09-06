require 'test_helper'

class ReviewCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get review_categories_show_url
    assert_response :success
  end

end
