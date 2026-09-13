module Api
  module V1
    class ClaimsController < BaseController
      def index
        claims = Claim.recent.limit(50)
        render json: claims.as_json(
          only: [:id, :title, :slug, :category, :verdict, :harm_score, :scientific_summary, :regulatory_warning, :created_at]
        )
      end

      def show
        claim = Claim.find_by!(slug: params[:id])
        render json: claim.as_json(
          only: [:id, :title, :slug, :category, :verdict, :harm_score, :scientific_summary, :regulatory_warning, :origin_vectors, :created_at],
          include: { evidence_citations: { only: [:id, :source, :external_id, :title, :url, :conclusion] } }
        )
      end

      def search
        query = params[:q]
        claims = Claim.search(query).recent.limit(20)
        render json: {
          query: query,
          count: claims.size,
          results: claims.as_json(only: [:id, :title, :slug, :category, :verdict, :harm_score, :scientific_summary])
        }
      end
    end
  end
end
