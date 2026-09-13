puts "== Seeding Pseudoscience Claims Database =="

claims_data = [
  {
    title: "Bleach / Chlorine Dioxide Ingestion Cures COVID-19 & Autism (MMS)",
    category: "Infectious Disease",
    verdict: :refuted,
    harm_score: 5,
    origin_vectors: ["TikTok Wellness", "Telegram Channels", "Alternative Health Blogs"],
    regulatory_warning: "FDA Warning Letter & Criminal Indictment: Ingestion of Miracle Mineral Solution (MMS) causes acute renal failure, hemolysis, and life-threatening toxicity.",
    scientific_summary: "Chlorine dioxide is a potent industrial bleaching agent. Ingestion leads to severe corrosive damage of the digestive tract, acute kidney injury, methemoglobinemia, and severe mucosal ulceration. There is zero clinical or pharmacological evidence supporting any antiviral or therapeutic activity in human physiology.",
    citations: [
      {
        source: "PubMed",
        external_id: "PMID: 32442256",
        title: "Toxicity of Chlorine Dioxide ingestion: A systematic review of acute intoxications",
        url: "https://pubmed.ncbi.nlm.nih.gov/32442256/",
        conclusion: "Ingestion of acidified sodium chlorite or chlorine dioxide is toxic and has led to multi-organ failure and death. No medicinal benefit exists."
      },
      {
        source: "FDA",
        external_id: "FDA-2020-MMS",
        title: "FDA Warns Consumers Not to Drink Miracle Mineral Solution",
        url: "https://www.fda.gov/consumers/consumer-updates/danger-dont-drink-miracle-mineral-solution-or-similar-products",
        conclusion: "The FDA has received multiple reports of severe vomiting, diarrhea, life-threatening low blood pressure, and acute liver failure from these unapproved products."
      }
    ]
  },
  {
    title: "Colloidal Silver as a Natural Antibiotic Alternative",
    category: "Alternative Medicine",
    verdict: :refuted,
    harm_score: 4,
    origin_vectors: ["Instagram Wellness Influencers", "Health Food Stores"],
    regulatory_warning: "FDA Final Rule 21 CFR Part 310: Over-the-counter colloidal silver products are not generally recognized as safe and effective.",
    scientific_summary: "Silver is not an essential mineral and serves no physiological function in the body. Oral consumption of colloidal silver deposits insoluble silver protein complexes irreversibly throughout skin, eyes, and internal organs, causing argyria (permanent slate-blue skin discoloration), nephrotoxicity, and neurological impairment.",
    citations: [
      {
        source: "PubMed",
        external_id: "PMID: 24083311",
        title: "Silver Products: Neurological and Dermatological Consequences",
        url: "https://pubmed.ncbi.nlm.nih.gov/24083311/",
        conclusion: "Long-term ingestion causes generalized argyria and potential seizure activity without providing antibiotic efficacy."
      }
    ]
  },
  {
    title: "Drinking Raw Milk Cures Lactose Intolerance & Asthma",
    category: "Dietary & Supplements",
    verdict: :refuted,
    harm_score: 4,
    origin_vectors: ["TikTok Trad-Diet", "X Biohackers"],
    regulatory_warning: "CDC and FDA Joint Warning: Raw milk is 840 times more likely to cause foodborne illness than pasteurized milk.",
    scientific_summary: "Unpasteurized milk contains the identical concentration of lactose as pasteurized milk (~4.8g per 100g) and does not contain active lactase enzymes that survive human stomach acid. It carries severe pathogens including Campylobacter, Salmonella, Listeria monocytogenes, and Shiga toxin-producing E. coli.",
    citations: [
      {
        source: "PubMed",
        external_id: "PMID: 24658729",
        title: "Effect of unpasteurized vs pasteurized milk on lactose malabsorption",
        url: "https://pubmed.ncbi.nlm.nih.gov/24658729/",
        conclusion: "Randomized controlled trial demonstrated raw milk did not reduce lactose malabsorption or self-reported digestive symptoms compared to pasteurized milk."
      }
    ]
  },
  {
    title: "Methylene Blue as Over-the-Counter Dementia & Alzheimer's Cure",
    category: "Neurology & Mental Health",
    verdict: :unsubstantiated,
    harm_score: 4,
    origin_vectors: ["Biohacking Podcasts", "YouTube Nootropics"],
    regulatory_warning: "FDA Public Warning: Methylene blue with serotonergic psychiatric medications risks life-threatening serotonin syndrome.",
    scientific_summary: "While purified pharmaceutical compounds are investigated in early clinical trials, industrial-grade dyes sold online as 'nootropics' are contaminated with heavy metals (lead, mercury, arsenic). When taken without medical supervision, it functions as a potent MAO inhibitor.",
    citations: [
      {
        source: "PubMed",
        external_id: "PMID: 21979312",
        title: "Methylene blue and serotonin toxicity: a clinical dilemma",
        url: "https://pubmed.ncbi.nlm.nih.gov/21979312/",
        conclusion: "Methylene blue is a potent monoamine oxidase inhibitor capable of precipitating lethal serotonin toxicity."
      }
    ]
  },
  {
    title: "Scalar Frequency Energy Pendants for 5G EMF Protection",
    category: "Devices & Biohacking",
    verdict: :refuted,
    harm_score: 3,
    origin_vectors: ["Facebook Marketplace", "TikTok Shop"],
    regulatory_warning: "European Nuclear Safety Authority: Radioactive 'anti-5G' pendants emit hazardous ionizing radiation.",
    scientific_summary: "Physical lab analysis has repeatedly proven that scalar energy and quantum EMF protection stickers have zero effect on radio frequency electromagnetic fields. Moreover, numerous products sold as 'negative ion' pendants contain radioactive monazite mineral powders that emit ionizing gamma and beta radiation directly against the wearer's chest.",
    citations: [
      {
        source: "ANVS",
        external_id: "ANVS-2021-01",
        title: "Radioactivity detected in consumer products claiming negative ion or 5G protection",
        url: "https://english.anvs.nl/latest/news/2021/12/16/radioactivity-in-anti-5g-pendants",
        conclusion: "Wearing these products continuously exposes the wearer to radiation levels exceeding statutory public limits."
      }
    ]
  },
  {
    title: "High-Dose Turmeric / Curcumin Cures Stage 4 Cancer",
    category: "Oncology / Cancer",
    verdict: :misrepresented,
    harm_score: 5,
    origin_vectors: ["Alternative Oncology Blogs", "Pinterest"],
    regulatory_warning: "FTC Enforcement: Civil penalties for fraudulent natural cancer cure marketing.",
    scientific_summary: "Curcumin has demonstrated in-vitro cellular cytotoxicity in petri dish studies, but has extremely poor human oral bioavailability. In human oncology trials, curcumin has never shown the ability to eradicate malignant tumors or substitute for surgery, radiation, or chemotherapy. Substituting herbal supplements for standard oncology care causes drastically increased mortality rates.",
    citations: [
      {
        source: "PubMed",
        external_id: "PMID: 29074092",
        title: "Use of Alternative Medicine for Cancer and Its Impact on Survival",
        url: "https://pubmed.ncbi.nlm.nih.gov/29074092/",
        conclusion: "Patients who choose alternative therapies instead of conventional cancer treatment have a substantially higher risk of death."
      }
    ]
  }
]

claims_data.each do |data|
  citations_data = data.delete(:citations)
  claim = Claim.find_or_initialize_by(title: data[:title])
  claim.update!(data)

  claim.evidence_citations.destroy_all
  citations_data.each do |c|
    claim.evidence_citations.create!(c)
  end
  puts " - Seeded claim: #{claim.title} (verdict: #{claim.verdict}, harm_score: #{claim.harm_score})"
end

puts "== Seeded #{Claim.count} claims with #{EvidenceCitation.count} citations =="
