class Claim < ApplicationRecord
  has_many :evidence_citations, dependent: :destroy
  has_many :reports, dependent: :nullify

  enum :verdict, {
    refuted: 0,
    unsubstantiated: 1,
    misrepresented: 2,
    preliminary: 3,
    supported: 4
  }, default: :refuted

  attribute :origin_vectors, default: -> { [] }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :category, presence: true
  validates :harm_score, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates :scientific_summary, presence: true

  before_validation :generate_slug, on: :create

  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :search, ->(query) {
    where("title ILIKE :q OR scientific_summary ILIKE :q", q: "%#{query}%") if query.present?
  }
  scope :high_risk, -> { where("harm_score >= 4") }
  scope :recent, -> { order(created_at: :desc) }

  CATEGORIES = [
    "Infectious Disease",
    "Dietary & Supplements",
    "Oncology / Cancer",
    "Neurology & Mental Health",
    "Devices & Biohacking",
    "Alternative Medicine"
  ].freeze

  def to_param
    slug
  end

  private

  def generate_slug
    return if slug.present? || title.blank?

    base_slug = title.parameterize
    self.slug = base_slug
    counter = 1
    while Claim.exists?(slug: slug)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end
