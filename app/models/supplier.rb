# frozen_string_literal: true

class Supplier < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[name website], using: { tsearch: { prefix: true } }
  has_one_attached :logo

  validates :name, presence: true
  validates :website, presence: true, uri: true

  scope :matching, ->(term) { search(term) if term.present? }

  def to_s
    name
  end
end
