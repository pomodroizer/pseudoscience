module Api
  module V1
    class LintController < BaseController
      def create
        text = params[:text] || params.dig(:lint, :text)
        
        if text.blank?
          render json: { error: "Missing required parameter 'text'" }, status: :bad_request
          return
        end

        result = Claims::LinterService.new(text: text).call

        render json: {
          status: result.status,
          risk_score: result.risk_score,
          compliant: result.compliant?,
          summary: result.summary,
          flagged_count: result.flagged_segments.size,
          flagged_segments: result.flagged_segments
        }
      end
    end
  end
end
