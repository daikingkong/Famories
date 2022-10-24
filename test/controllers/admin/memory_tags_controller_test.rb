require "test_helper"

class Admin::MemoryTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_memory_tags_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_memory_tags_destroy_url
    assert_response :success
  end
end
