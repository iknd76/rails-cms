# frozen_string_literal: true

class ArticleCategory < ApplicationRecord
  has_many :articles, dependent: :destroy
  acts_as_list
  translates :name

  validates :name_en, presence: true
  validates :name_el, presence: true
  validates :slug, presence: true, uniqueness: true, slug: true

  def to_s
    name
  end
end
