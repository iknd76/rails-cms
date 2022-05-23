# frozen_string_literal: true

class Activity < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[trackable_name action], using: { tsearch: { prefix: true } }
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  before_validation :set_trackable_name

  validates :trackable_name, presence: true
  validates :action, presence: true

  scope :matching, ->(term) { search(term) if term.present? }
  scope :by_user, ->(user_id) { where(user_id:) if user_id.present? }

  def self.history_for(trackable)
    where(trackable:).includes(:user).order(id: :desc)
  end

  private

  def set_trackable_name
    self.trackable_name = trackable.to_s
  end
end
