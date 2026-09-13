require 'rails_helper'

RSpec.describe "Api::V1::Claims", type: :request do
  let!(:claim) { create(:claim, title: "Chlorine Dioxide Cures COVID", harm_score: 5) }
  let!(:citation) { create(:evidence_citation, claim: claim) }

  describe "GET /api/v1/claims" do
    it "returns list of indexed claims" do
      get "/api/v1/claims"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to be >= 1
      expect(json.first["title"]).to eq(claim.title)
    end
  end

  describe "GET /api/v1/claims/:slug" do
    it "returns specific claim with citations" do
      get "/api/v1/claims/#{claim.slug}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["title"]).to eq(claim.title)
      expect(json["evidence_citations"].size).to eq(1)
    end
  end

  describe "GET /api/v1/claims/search" do
    it "returns search results matching query" do
      get "/api/v1/claims/search", params: { q: "Chlorine" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["count"]).to eq(1)
      expect(json["results"].first["title"]).to include("Chlorine Dioxide")
    end
  end
end
