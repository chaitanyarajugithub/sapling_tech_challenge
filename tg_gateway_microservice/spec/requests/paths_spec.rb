require 'rails_helper'

RSpec.describe "Paths", type: :request do
  describe 'GET /api/v1/requests' do
    service = "auth"
    path = "/devise_users"
    before { get "/api/v1/requests?service=#{service}&path=#{path}"}

    it 'returns users' do
      result = JSON(response)
      expect(response).to have_http_status(:success)
      expect(result).not_to be_empty
      expect(result.length).to be >= 0
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
