require "test_helper"

class PetControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pet_index_url
    assert_response :success
  end
end
