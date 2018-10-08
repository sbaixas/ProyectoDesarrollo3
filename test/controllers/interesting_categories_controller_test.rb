require 'test_helper'

class InterestingCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get interesting_categories_edit_url
    assert_response :success
  end

end
