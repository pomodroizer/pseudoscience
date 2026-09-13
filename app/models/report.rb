class Report < ApplicationRecord
  belongs_to :claim, optional: true

  enum :status, {
    pending: 0,
    analyzing: 1,
    verified: 2,
    dismissed: 3
  }, default: :pending

  attribute :metadata, default: -> { {} }

  validates :claim_text, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
