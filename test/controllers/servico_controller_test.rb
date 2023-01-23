require "test_helper"

class ServicoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servico_index_url
    assert_response :success
  end
end
