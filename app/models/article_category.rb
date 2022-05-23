# frozen_string_literal: true

class ArticleCategory < ApplicationRecord
  acts_as_list
  translates :name
  has_many :articles, dependent: :destroy

  validates :name_en, presence: true
  validates :name_el, presence: true
  validates :slug, presence: true, uniqueness: true, slug: true

  def to_s
    name
  end
end
