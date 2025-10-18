require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end 
      
    let(:invalid_attributes) do
      {
        student: {
          first_name: "",
          last_name: "",
          email: "not-an-email"
        }
      }  
    end

    it "creates a new student" do
      expect {
        post '/api/v1/students', params: valid_attributes
      }.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@example.com")
    end
    it "does not create a student with invalid attributes" do
      expect {
        post '/api/v1/students', params: invalid_attributes
      }.not_to change(Student, :count)

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body)
      expect(body).to have_key("errors")
      expect(body["errors"]).to include("Email is invalid")
    end
  end
end 
