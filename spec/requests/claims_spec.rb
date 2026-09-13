require 'rails_helper'

RSpec.describe "Claims", type: :request do
  let!(:claim) { create(:claim, title: "Drinking Bleach Cures Flu", harm_score: 5) }

  describe "GET /claims" do
    it "renders the claims index page successfully" do
      get claims_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Drinking Bleach Cures Flu")
    end

    it "filters claims by search query" do
      get claims_path, params: { q: "Bleach" }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Drinking Bleach Cures Flu")
    end
  end

  describe "GET /claims/:slug" do
    it "renders the claim detail page" do
      get claim_path(claim)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(claim.title)
      expect(response.body).to include(claim.scientific_summary)
    end
  end
end
