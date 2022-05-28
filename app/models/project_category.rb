# frozen_string_literal: true

class ProjectCategory < ApplicationRecord
  belongs_to :parent, class_name: "ProjectCategory", optional: true
  has_many :children, -> { order(:position) }, class_name: "ProjectCategory", foreign_key: :parent_id, dependent: :nullify, inverse_of: :parent
  has_many :projects, dependent: :destroy
  acts_as_list scope: :parent
  translates :name

  validates :name_en, presence: true
  validates :name_el, presence: true
  validates :slug, presence: true, uniqueness: true, slug: true
  validate :parent_assignment

  scope :roots, -> { where(parent_id: nil).includes(:children).order(:position) }

  def root?
    parent_id.blank?
  end

  def leaf?
    parent_id.present?
  end

  def to_s
    name
  end

  private

  def parent_assignment
    return unless parent

    if parent == self
      errors.add(:parent_id, :not_self)
    elsif parent.leaf?
      errors.add(:parent_id, :not_root)
    elsif children.any?
      errors.add(:parent_id, :assigned_children)
    end
  end
end
