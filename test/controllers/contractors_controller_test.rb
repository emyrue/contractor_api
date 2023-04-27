require 'test_helper'

class ContractorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contractor = contractors(:one)
  end

  test 'should get index' do
    get contractors_url, as: :json
    assert_response :success
  end

  test 'should create contractor' do
    assert_difference('Contractor.count') do
      post contractors_url,
           params: { contractor: { bio: @contractor.bio, name: @contractor.name, rate: @contractor.rate } }, as: :json
    end

    assert_response :created
  end

  test 'should show contractor' do
    get contractor_url(@contractor), as: :json
    assert_response :success
  end

  test 'should update contractor' do
    patch contractor_url(@contractor),
          params: { contractor: { bio: @contractor.bio, name: @contractor.name, rate: @contractor.rate } }, as: :json
    assert_response :success
  end

  test 'should destroy contractor' do
    assert_difference('Contractor.count', -1) do
      delete contractor_url(@contractor), as: :json
    end

    assert_response :no_content
  end
end
