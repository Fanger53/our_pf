require "test_helper"

class PortfolioSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get portfolio_sections_new_url
    assert_response :success
  end

  test "should get create" do
    get portfolio_sections_create_url
    assert_response :success
  end

  test "should get edit" do
    get portfolio_sections_edit_url
    assert_response :success
  end

  test "should get update" do
    get portfolio_sections_update_url
    assert_response :success
  end

  test "should get destroy" do
    get portfolio_sections_destroy_url
    assert_response :success
  end
end
