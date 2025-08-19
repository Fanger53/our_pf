require "test_helper"

class PublicPortfoliosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_portfolios_show_url
    assert_response :success
  end
end
