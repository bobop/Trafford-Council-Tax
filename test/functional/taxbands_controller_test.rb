require 'test_helper'

class TaxbandsControllerTest < ActionController::TestCase
  setup do
    @taxband = taxbands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxbands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxband" do
    assert_difference('Taxband.count') do
      post :create, :taxband => @taxband.attributes
    end

    assert_redirected_to taxband_path(assigns(:taxband))
  end

  test "should show taxband" do
    get :show, :id => @taxband.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @taxband.to_param
    assert_response :success
  end

  test "should update taxband" do
    put :update, :id => @taxband.to_param, :taxband => @taxband.attributes
    assert_redirected_to taxband_path(assigns(:taxband))
  end

  test "should destroy taxband" do
    assert_difference('Taxband.count', -1) do
      delete :destroy, :id => @taxband.to_param
    end

    assert_redirected_to taxbands_path
  end
end
