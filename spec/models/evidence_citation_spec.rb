require 'rails_helper'

RSpec.describe EvidenceCitation, type: :model do
  let(:claim) { create(:claim) }

  it 'is valid with valid attributes' do
    citation = build(:evidence_citation, claim: claim)
    expect(citation).to be_valid
  end

  it 'requires a valid URL format' do
    citation = build(:evidence_citation, claim: claim, url: 'invalid-url')
    expect(citation).not_to be_valid
  end

  it 'belongs to a claim' do
    citation = create(:evidence_citation, claim: claim)
    expect(citation.claim).to eq(claim)
  end
end
