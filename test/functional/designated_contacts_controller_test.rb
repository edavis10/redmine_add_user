require 'test_helper'

class DesignatedContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:designated_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create designated_contact" do
    assert_difference('DesignatedContact.count') do
      post :create, :designated_contact => { }
    end

    assert_redirected_to designated_contact_path(assigns(:designated_contact))
  end

  test "should show designated_contact" do
    get :show, :id => designated_contacts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => designated_contacts(:one).to_param
    assert_response :success
  end

  test "should update designated_contact" do
    put :update, :id => designated_contacts(:one).to_param, :designated_contact => { }
    assert_redirected_to designated_contact_path(assigns(:designated_contact))
  end

  test "should destroy designated_contact" do
    assert_difference('DesignatedContact.count', -1) do
      delete :destroy, :id => designated_contacts(:one).to_param
    end

    assert_redirected_to designated_contacts_path
  end
end
