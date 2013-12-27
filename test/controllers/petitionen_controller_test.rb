require 'test_helper'

class PetitionenControllerTest < ActionController::TestCase
  setup do
    @petition = petitionen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:petitionen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create petition" do
    assert_difference('Petition.count') do
      post :create, petition: { anzahl_dagegen_cached: @petition.anzahl_dagegen_cached, anzahl_spam_cached: @petition.anzahl_spam_cached, anzahl_unterstuetzer_cached: @petition.anzahl_unterstuetzer_cached, datum_entzensiert: @petition.datum_entzensiert, datum_erstellt: @petition.datum_erstellt, datum_veroeffentlicht: @petition.datum_veroeffentlicht, datum_zensiert: @petition.datum_zensiert, datum_zuletzt_bearbeitet: @petition.datum_zuletzt_bearbeitet, inhalt: @petition.inhalt, inhalt_zensiert: @petition.inhalt_zensiert, ist_zensiert: @petition.ist_zensiert, titel: @petition.titel, titel_zensiert: @petition.titel_zensiert, user_id: @petition.user_id }
    end

    assert_redirected_to petition_path(assigns(:petition))
  end

  test "should show petition" do
    get :show, id: @petition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @petition
    assert_response :success
  end

  test "should update petition" do
    patch :update, id: @petition, petition: { anzahl_dagegen_cached: @petition.anzahl_dagegen_cached, anzahl_spam_cached: @petition.anzahl_spam_cached, anzahl_unterstuetzer_cached: @petition.anzahl_unterstuetzer_cached, datum_entzensiert: @petition.datum_entzensiert, datum_erstellt: @petition.datum_erstellt, datum_veroeffentlicht: @petition.datum_veroeffentlicht, datum_zensiert: @petition.datum_zensiert, datum_zuletzt_bearbeitet: @petition.datum_zuletzt_bearbeitet, inhalt: @petition.inhalt, inhalt_zensiert: @petition.inhalt_zensiert, ist_zensiert: @petition.ist_zensiert, titel: @petition.titel, titel_zensiert: @petition.titel_zensiert, user_id: @petition.user_id }
    assert_redirected_to petition_path(assigns(:petition))
  end

  test "should destroy petition" do
    assert_difference('Petition.count', -1) do
      delete :destroy, id: @petition
    end

    assert_redirected_to petitionen_path
  end
end
