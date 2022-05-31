# frozen_string_literal: true

class Article < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[title body tags], using: { tsearch: { prefix: true } }
  belongs_to :article_category, counter_cache: true
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [96, 96]
  end
  enum status: { draft: 0, published: 1 }

  before_validation :set_published_on

  validates :locale, presence: true, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :title, presence: true
  validates :body, presence: true
  validates :status, presence: true

  scope :matching, ->(term) { search(term) if term.present? }
  scope :in_category, ->(id) { where(article_category_id: id) if id.present? }
  scope :with_status, ->(value) { where(status: value) if value.present? }
  scope :in_locale, ->(value) { where(locale: value) if value.present? }

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
end
