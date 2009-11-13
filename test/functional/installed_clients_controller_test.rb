require 'test_helper'

class InstalledClientsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:installed_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create installed_client" do
    assert_difference('InstalledClient.count') do
      post :create, :installed_client => { }
    end

    assert_redirected_to installed_client_path(assigns(:installed_client))
  end

  test "should show installed_client" do
    get :show, :id => installed_clients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => installed_clients(:one).to_param
    assert_response :success
  end

  test "should update installed_client" do
    put :update, :id => installed_clients(:one).to_param, :installed_client => { }
    assert_redirected_to installed_client_path(assigns(:installed_client))
  end

  test "should destroy installed_client" do
    assert_difference('InstalledClient.count', -1) do
      delete :destroy, :id => installed_clients(:one).to_param
    end

    assert_redirected_to installed_clients_path
  end
end
