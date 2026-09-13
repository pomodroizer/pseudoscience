class ClaimsController < ApplicationController
  def index
    @categories = Claim::CATEGORIES
    @claims = Claim.all

    if params[:q].present?
      @claims = @claims.search(params[:q])
    end

    if params[:category].present?
      @claims = @claims.by_category(params[:category])
    end

    if params[:verdict].present?
      @claims = @claims.where(verdict: params[:verdict])
    end

    if params[:min_harm].present?
      @claims = @claims.where("harm_score >= ?", params[:min_harm].to_i)
    end

    @claims = @claims.recent
  end

  def show
    @claim = Claim.find_by!(slug: params[:slug])
    @citations = @claim.evidence_citations
  end
end
