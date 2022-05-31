# frozen_string_literal: true

class Page < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[title_en title_el body_en body_el description_en description_el], using: { tsearch: { prefix: true } }
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [96, 96]
  end
  translates :title, :body, :description, :keywords

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
