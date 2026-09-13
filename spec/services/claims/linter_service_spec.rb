require 'rails_helper'

RSpec.describe Claims::LinterService do
  subject { described_class.new(text: text).call }

  context 'when copy contains clean, compliant structure/function claims' do
    let(:text) { "Our organic magnesium complex supports restful sleep and normal muscle relaxation." }

    it 'returns compliant status with a low risk score' do
      expect(subject.status).to eq(:compliant)
      expect(subject.risk_score).to eq(1)
      expect(subject.flagged_segments).to be_empty
      expect(subject.compliant?).to be true
    end
  end

  context 'when copy makes illegal disease claims' do
    let(:text) { "Our mushroom extract cures clinical depression and eliminates cancer cells permanently." }

    it 'flags illegal disease cure claims and suggests compliant alternatives' do
      expect(subject.status).to eq(:prohibited_claims)
      expect(subject.risk_score).to be >= 4
      expect(subject.compliant?).to be false
      expect(subject.flagged_segments.size).to be >= 2

      matches = subject.flagged_segments.map { |s| s[:matched_text].downcase }
      expect(matches).to include("cures clinical depression")
      expect(matches.any? { |m| m.include?("eliminates cancer") }).to be true

      # Checks for compliant rewrite suggestion
      cure_flag = subject.flagged_segments.find { |s| s[:matched_text].downcase.include?("cures") }
      expect(cure_flag[:suggested_replacement]).to be_present
      expect(cure_flag[:regulation]).to include("FDA")
    end
  end

  context 'when copy mentions dangerous unapproved chemicals' do
    let(:text) { "Drinking 10 drops of chlorine dioxide / MMS detoxifies organs and treats viral infection." }

    it 'assigns critical severity 5 for toxic ingestion' do
      expect(subject.risk_score).to eq(5)
      expect(subject.status).to eq(:prohibited_claims)
      
      chemical_flag = subject.flagged_segments.find { |s| s[:matched_text].downcase.include?("chlorine dioxide") }
      expect(chemical_flag).to be_present
      expect(chemical_flag[:severity]).to eq(5)
    end
  end

  context 'when text is blank or empty' do
    let(:text) { "" }

    it 'returns clean result without errors' do
      expect(subject.status).to eq(:compliant)
      expect(subject.risk_score).to eq(1)
      expect(subject.flagged_segments).to be_empty
    end
  end
end
