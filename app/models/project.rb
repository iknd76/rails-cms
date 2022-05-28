# frozen_string_literal: true

class Project < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[title_en title_el body_en body_el tags], using: { tsearch: { prefix: true } }
  belongs_to :project_category, counter_cache: true
  enum status: { draft: 0, published: 1 }
  translates :title, :body

  before_validation :set_published_on

  validates :title_en, presence: true
  validates :title_el, presence: true
  validates :body_en, presence: true
  validates :body_el, presence: true
  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lng, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :status, presence: true
  validate :project_category_level

  scope :matching, ->(term) { search(term) if term.present? }
  scope :in_category, ->(id) { where(project_category_id: id) if id.present? }
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

  def project_category_level
    errors.add(:project_category, :root) if project_category&.root?
  end
end
