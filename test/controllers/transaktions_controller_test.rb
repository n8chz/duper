require 'test_helper'

class TransaktionsControllerTest < ActionController::TestCase
  setup do
    @transaktion = transaktions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transaktions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaktion" do
    assert_difference('Transaktion.count') do
      post :create, transaktion: { date: @transaktion.date, entity_id: @transaktion.entity_id, is_void: @transaktion.is_void }
    end

    assert_redirected_to transaktion_path(assigns(:transaktion))
  end

  test "should show transaktion" do
    get :show, id: @transaktion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaktion
    assert_response :success
  end

  test "should update transaktion" do
    patch :update, id: @transaktion, transaktion: { date: @transaktion.date, entity_id: @transaktion.entity_id, is_void: @transaktion.is_void }
    assert_redirected_to transaktion_path(assigns(:transaktion))
  end

  test "should destroy transaktion" do
    assert_difference('Transaktion.count', -1) do
      delete :destroy, id: @transaktion
    end

    assert_redirected_to transaktions_path
  end
end
