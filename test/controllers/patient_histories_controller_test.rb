require 'test_helper'

class PatientHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient_history = patient_histories(:one)
  end

  test "should get index" do
    get patient_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_patient_history_url
    assert_response :success
  end

  test "should create patient_history" do
    assert_difference('PatientHistory.count') do
      post patient_histories_url, params: { patient_history: { diagnosis: @patient_history.diagnosis, physicals: @patient_history.physicals, prescription: @patient_history.prescription, symptoms: @patient_history.symptoms, tests: @patient_history.tests } }
    end

    assert_redirected_to patient_history_url(PatientHistory.last)
  end

  test "should show patient_history" do
    get patient_history_url(@patient_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_patient_history_url(@patient_history)
    assert_response :success
  end

  test "should update patient_history" do
    patch patient_history_url(@patient_history), params: { patient_history: { diagnosis: @patient_history.diagnosis, physicals: @patient_history.physicals, prescription: @patient_history.prescription, symptoms: @patient_history.symptoms, tests: @patient_history.tests } }
    assert_redirected_to patient_history_url(@patient_history)
  end

  test "should destroy patient_history" do
    assert_difference('PatientHistory.count', -1) do
      delete patient_history_url(@patient_history)
    end

    assert_redirected_to patient_histories_url
  end
end
