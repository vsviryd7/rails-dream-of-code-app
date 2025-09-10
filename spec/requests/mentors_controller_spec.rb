require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    before do
      @mentor1 = Mentor.create!(
        first_name: "Olga",
        last_name: "Sviridenko",
        email: "osviridenko@example.com"
      )
      @mentor2 = Mentor.create!(
        first_name: "Mike",
        last_name: "Wolf",
        email: "mwolf@example.com"
      )
    end

    it "returns a page containing all mentors' names" do
      get "/mentors"
      expect(response).to have_http_status(:ok)

      # Check mentor1
      expect(response.body).to include(@mentor1.first_name)
      expect(response.body).to include(@mentor1.last_name)

      # Check mentor2
      expect(response.body).to include(@mentor2.first_name)
      expect(response.body).to include(@mentor2.last_name)
    end
  end
end