require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /reports/new" do
    it "renders the report submission form" do
      get new_report_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Report a Pseudoscience Claim")
    end
  end

  describe "POST /reports" do
    it "creates a new report with valid params" do
      expect {
        post reports_path, params: { report: { claim_text: "Viral reel claims borax cleanses heavy metals", source_url: "https://tiktok.com/@video", platform: "TikTok" } }
      }.to change(Report, :count).by(1)

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Thank you. Your report has been submitted")
    end

    it "fails validation if claim_text is blank" do
      post reports_path, params: { report: { claim_text: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Please provide the claim text")
    end
  end
end
