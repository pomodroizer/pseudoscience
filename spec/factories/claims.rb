FactoryBot.define do
  factory :claim do
    title { "Chlorine Dioxide Ingestion Cures Viral Illness" }
    category { "Infectious Disease" }
    verdict { :refuted }
    harm_score { 5 }
    scientific_summary { "Industrial bleaching chemical causing acute renal failure, hemolysis, and severe mucosal ulceration with zero antimicrobial benefit in vivo." }
    regulatory_warning { "FDA Warning Letter 2020: Fraudulent COVID-19 product notification." }
    origin_vectors { ["TikTok Wellness", "Alternative Health Telegram"] }
  end
end
