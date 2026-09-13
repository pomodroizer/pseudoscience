class EvidenceCitation < ApplicationRecord
  belongs_to :claim

  validates :source, presence: true
  validates :title, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid HTTP or HTTPS URL" }
end
