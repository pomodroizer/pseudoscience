require 'rails_helper'

RSpec.describe "Api::V1::Lint", type: :request do
  describe "POST /api/v1/lint" do
    it "returns JSON analysis for compliant text" do
      post "/api/v1/lint", params: { text: "Magnesium glycinate supports restful sleep." }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["compliant"]).to be true
      expect(json["risk_score"]).to eq(1)
      expect(json["flagged_segments"]).to be_empty
    end

    it "detects and flags illegal disease claims" do
      post "/api/v1/lint", params: { text: "Mushroom tincture cures clinical depression and eliminates cancer." }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["compliant"]).to be false
      expect(json["risk_score"]).to be >= 4
      expect(json["flagged_count"]).to be >= 2
    end

    it "returns 400 when text parameter is missing" do
      post "/api/v1/lint", params: {}
      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json["error"]).to include("Missing required parameter")
    end
  end
end
