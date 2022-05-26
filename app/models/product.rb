# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[title_en title_el body_en body_el tags], using: { tsearch: { prefix: true } }
  belongs_to :product_category, counter_cache: true
  belongs_to :supplier, counter_cache: true
  enum status: { draft: 0, published: 1 }
  translates :title, :body

  before_validation :set_published_on

  validates :title_en, presence: true
  validates :title_el, presence: true
  validates :body_en, presence: true
  validates :body_el, presence: true
  validates :status, presence: true
  validate :product_category_level

  scope :matching, ->(term) { search(term) if term.present? }
  scope :in_category, ->(id) { where(product_category_id: id) if id.present? }
  scope :by_supplier, ->(id) { where(supplier_id: id) if id.present? }
  scope :with_status, ->(value) { where(status: value) if value.present? }

  def to_s
    title
  end

  private

  def set_published_on
    if published?
      self.published_on ||= Time.zone.today
    else
      self.published_on = nil
    end
  end

  def product_category_level
    errors.add(:product_category, :root) if product_category&.root?
  end
end
