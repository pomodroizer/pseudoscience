class HomeController < ApplicationController
  def index
    @categories = Claim::CATEGORIES
    @featured_claims = Claim.recent.limit(6)
    @high_risk_claims = Claim.high_risk.limit(4)
    @total_claims_count = Claim.count
  end
end
