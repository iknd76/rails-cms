# frozen_string_literal: true

class Snippet < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[title_en title_el body_en body_el], using: { tsearch: { prefix: true } }
  translates :title, :body

  validates :slug, presence: true, uniqueness: true, slug: true
  validates :title_en, presence: true
  validates :title_el, presence: true
  validates :body_en, presence: true
  validates :body_el, presence: true

  scope :matching, ->(term) { search(term) if term.present? }

  def to_s
    title
  end
end
