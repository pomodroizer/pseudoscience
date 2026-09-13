require 'rails_helper'

RSpec.describe Report, type: :model do
  it 'is valid with valid attributes' do
    report = build(:report)
    expect(report).to be_valid
  end

  it 'defaults status to pending' do
    report = create(:report)
    expect(report.status).to eq('pending')
  end

  it 'is invalid without claim_text' do
    report = build(:report, claim_text: nil)
    expect(report).not_to be_valid
  end
end
