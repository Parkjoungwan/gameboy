require "test_helper"

class MovieControllerTest < ActionDispatch::IntegrationTest
  test "should get title_screen" do
    get movie_title_screen_url
    assert_response :success
  end

  test "should get save_slot" do
    get movie_save_slot_url
    assert_response :success
  end

  test "should get worldmap" do
    get movie_worldmap_url
    assert_response :success
  end

  test "should get battle" do
    get movie_battle_url
    assert_response :success
  end

  test "should get moviedex" do
    get movie_moviedex_url
    assert_response :success
  end

  test "should get lose" do
    get movie_lose_url
    assert_response :success
  end

  test "should get win" do
    get movie_win_url
    assert_response :success
  end
end
