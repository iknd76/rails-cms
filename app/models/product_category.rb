# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  belongs_to :parent, class_name: "ProductCategory", optional: true
  has_many :children, -> { order(:position) }, class_name: "ProductCategory", foreign_key: :parent_id, dependent: :nullify, inverse_of: :parent
  acts_as_list scope: :parent
  translates :name

  validates :name_en, presence: true
  validates :name_el, presence: true
  validates :slug, presence: true, uniqueness: true, slug: true
  validate :parent_assignment

  scope :roots, -> { where(parent_id: nil).order(:position) }

  def root?
    parent_id.blank?
  end

  def child?
    !root?
  end

  def to_s
    name
  end

  private

  def parent_assignment
    return unless parent

    if parent == self
      errors.add(:parent_id, :not_self)
    elsif parent.child?
      errors.add(:parent_id, :not_root)
    elsif children.any?
      errors.add(:parent_id, :assigned_children)
    end
  end
end
