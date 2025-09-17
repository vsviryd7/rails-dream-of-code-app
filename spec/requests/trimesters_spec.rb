require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  let!(:trimester) { Trimester.create!(year: "2023", term: "Fall", application_deadline: "2023-08-15", start_date: "2023-09-01", end_date: "2023-11-30") }

  describe "GET /trimesters/:id/edit" do
    it "shows the application deadline label" do
      get edit_trimester_path(trimester)
      expect(response.body).to include("Application Deadline")
    end
  end

  describe "PUT /trimesters/:id" do
    it "updates application_deadline with valid date" do
      put trimester_path(trimester), params: { trimester: { application_deadline: "2023-09-01" } }
      expect(response).to redirect_to(trimester_path(trimester))
      follow_redirect!
      expect(response.body).to include("Trimester was successfully updated")
      expect(trimester.reload.application_deadline).to eq(Date.parse("2023-09-01"))
    end

    it "returns 400 if application_deadline missing" do
      put trimester_path(trimester), params: { trimester: { application_deadline: "" } }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 400 if application_deadline invalid" do
      put trimester_path(trimester), params: { trimester: { application_deadline: "not-a-date" } }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 404 if trimester not found" do
      put trimester_path(-1), params: { trimester: { application_deadline: "2023-09-01" } }
      expect(response).to have_http_status(:not_found)
    end
  end
end