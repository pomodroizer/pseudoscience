FactoryBot.define do
  factory :report do
    claim_text { "Video claims drinking 1 tsp borax daily cleanses heavy metals and cures arthritis" }
    source_url { "https://tiktok.com/@example/video/123456789" }
    platform { "TikTok" }
    status { :pending }
  end
end
