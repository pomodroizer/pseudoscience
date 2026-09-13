module Claims
  class LinterService
    Result = Struct.new(:status, :risk_score, :flagged_segments, :summary, :processed_text, keyword_init: true) do
      def compliant?
        status == :compliant
      end
    end

    PROHIBITED_PATTERNS = [
      {
        regex: /\b(cures?|eliminates?|heals?|treats?|reverses?)\s+([a-z\s]{0,30}?\b(depression|cancer|diabetes|alzheimer(?:'s)?|covid(?:-19)?|tumors?|arthritis|autism)\b)/i,
        category: "Illegal Disease Claim",
        severity: 5,
        regulation: "FDA 21 CFR 101.93 & FTC Act Section 5",
        reason: "Dietary supplements and cosmetics cannot claim to cure, treat, mitigate, or reverse specific clinical diseases.",
        replacement_map: {
          "depression" => "supports a balanced mood and mental well-being",
          "cancer" => "provides dietary antioxidant support for healthy cells",
          "diabetes" => "helps maintain blood sugar levels already within normal range",
          "alzheimer" => "supports healthy cognitive function and brain clarity",
          "covid" => "supports a healthy, resilient immune system",
          "arthritis" => "supports joint mobility and occasional joint comfort",
          "autism" => "supports healthy neurological function"
        }
      },
      {
        regex: /\b(prevents?|protects? against)\s+([a-z\s]*\b(covid(?:-19)?|cancer|flu|influenza|viral infection)\b)/i,
        category: "Illegal Disease Prevention Claim",
        severity: 4,
        regulation: "FDA 21 CFR 101.93",
        reason: "Products marketed as supplements cannot claim to prevent viral infections or chronic diseases without drug approval.",
        replacement_map: {
          "covid" => "supports everyday immune defense",
          "cancer" => "supports general cellular health",
          "flu" => "supports seasonal immune vitality",
          "viral infection" => "supports natural immune resilience"
        }
      },
      {
        regex: /\b(chlorine dioxide|mms\b|miracle mineral solution|colloidal silver|borax|turpentine)\b/i,
        category: "Dangerous / Toxic Substance Warning",
        severity: 5,
        regulation: "FDA Consumer Warning & Safety Recall",
        reason: "Substance has documented human toxicity (corrosive injury, organ failure, or argyria) with no therapeutic approval.",
        default_suggestion: "Discontinue marketing of non-approved hazardous substances."
      },
      {
        regex: /\b(quantum healing|scalar frequency|scalar wave|detoxifies organs|5g radiation protection|parasite cleanse for adhd)\b/i,
        category: "Deceptive Pseudoscience Buzzword",
        severity: 3,
        regulation: "FTC Deceptive Advertising Guidelines",
        reason: "Unsubstantiated mechanism with no randomized double-blind clinical evidence.",
        default_suggestion: "Use verified mechanism descriptions backed by peer-reviewed human trials."
      }
    ].freeze

    def initialize(text:)
      @text = text.to_s.strip
    end

    def call
      return clean_result if @text.blank?

      flagged = []

      PROHIBITED_PATTERNS.each do |pattern|
        @text.scan(pattern[:regex]) do
          full_match = Regexp.last_match[0]
          
          suggestion = generate_suggestion(pattern, full_match)

          flagged << {
            matched_text: full_match,
            category: pattern[:category],
            severity: pattern[:severity],
            regulation: pattern[:regulation],
            reason: pattern[:reason],
            suggested_replacement: suggestion
          }
        end
      end

      calculate_result(flagged)
    end

    private

    def generate_suggestion(pattern, match_text)
      if pattern[:replacement_map]
        match_lower = match_text.downcase
        pattern[:replacement_map].each do |keyword, safe_phrase|
          return safe_phrase if match_lower.include?(keyword)
        end
      end

      pattern[:default_suggestion] || "Reframe as a structure/function statement supporting normal physiological processes."
    end

    def calculate_result(flagged)
      if flagged.empty?
        clean_result
      else
        max_severity = flagged.map { |f| f[:severity] }.max
        status = max_severity >= 4 ? :prohibited_claims : :moderate_risk

        Result.new(
          status: status,
          risk_score: max_severity,
          flagged_segments: flagged,
          summary: "Identified #{flagged.size} compliance issue(s). Highest risk severity: #{max_severity}/5.",
          processed_text: @text
        )
      end
    end

    def clean_result
      Result.new(
        status: :compliant,
        risk_score: 1,
        flagged_segments: [],
        summary: "No prohibited disease or toxic claims detected. Copy conforms to general structure/function requirements.",
        processed_text: @text
      )
    end
  end
end
