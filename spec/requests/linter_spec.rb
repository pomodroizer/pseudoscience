require 'rails_helper'

RSpec.describe "Linter", type: :request do
  describe "GET /linter" do
    it "renders the linter interface" do
      get linter_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Health Claim Compliance Linter")
    end
  end

  describe "POST /linter/check" do
    it "evaluates copy and renders findings" do
      post linter_check_path, params: { text: "Our herbal tea cures cancer and eliminates diabetes." }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Illegal Disease Claim")
    end
  end
end
