require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  let!(:js_class) do
    CodingClass.create!(title: 'Intro to Javascript')
  end

  let!(:rails_class) do
    CodingClass.create!(title: 'Ruby on Rails')
  end
  
    before do
      current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      # Define past_trimester here and uncomment it when you're ready.
      upcoming_trimester = Trimester.create!(
        term: 'Upcoming term',
        year: Date.today.year.to_s,
        start_date: Date.today + 4.months,
        end_date: Date.today + 6.months,
        application_deadline: Date.today + 3.months
      )   
    end
  describe 'GET /dashboard' do
    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get '/dashboard'

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("Current term")
    end

    it 'displays links to the courses in the current trimester' do
      get '/dashboard'
      expect(response.body).to include('Intro to Javascript')
      expect(response.body).to include('Ruby on Rails')
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("Upcoming term")
    end

    it 'displays links to the courses in the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include('Intro to Javascript')
      expect(response.body).to include('Ruby on Rails')
    end
  end
end
