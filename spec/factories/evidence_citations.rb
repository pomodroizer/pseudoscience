FactoryBot.define do
  factory :evidence_citation do
    claim
    source { "PubMed" }
    external_id { "PMID: 32442256" }
    title { "Toxicity of Chlorine Dioxide ingestion: A systematic review" }
    url { "https://pubmed.ncbi.nlm.nih.gov/32442256/" }
    conclusion { "No therapeutic benefit demonstrated in clinical human trials; severe toxicity documented." }
  end
end
