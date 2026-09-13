require 'rails_helper'

RSpec.describe Claim, type: :model do
  describe 'validations' do
    subject { build(:claim) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'is invalid without a category' do
      subject.category = nil
      expect(subject).not_to be_valid
    end

    it 'is invalid without scientific_summary' do
      subject.scientific_summary = nil
      expect(subject).not_to be_valid
    end

    it 'validates harm_score between 1 and 5' do
      subject.harm_score = 0
      expect(subject).not_to be_valid

      subject.harm_score = 6
      expect(subject).not_to be_valid

      subject.harm_score = 4
      expect(subject).to be_valid
    end

    it 'auto-generates a parameterized unique slug before validation' do
      claim = create(:claim, title: "Drinking Bleach Cures Flu")
      expect(claim.slug).to eq("drinking-bleach-cures-flu")

      duplicate_claim = create(:claim, title: "Drinking Bleach Cures Flu")
      expect(duplicate_claim.slug).to eq("drinking-bleach-cures-flu-1")
    end
  end

  describe 'scopes' do
    let!(:high_risk_claim) { create(:claim, harm_score: 5, category: "Infectious Disease", title: "Bleach Ingestion") }
    let!(:low_risk_claim) do
      create(:claim, harm_score: 2, category: "Devices & Biohacking", title: "Scalar Wave Sticker",
                     scientific_summary: "Inert holographic sticker with no measurable electromagnetic attenuation.")
    end

    it 'filters by category' do
      expect(Claim.by_category("Infectious Disease")).to include(high_risk_claim)
      expect(Claim.by_category("Infectious Disease")).not_to include(low_risk_claim)
    end

    it 'filters high risk claims (harm_score >= 4)' do
      expect(Claim.high_risk).to include(high_risk_claim)
      expect(Claim.high_risk).not_to include(low_risk_claim)
    end

    it 'searches by title or scientific summary' do
      results = Claim.search("Bleach")
      expect(results).to include(high_risk_claim)
      expect(results).not_to include(low_risk_claim)
    end
  end
end
