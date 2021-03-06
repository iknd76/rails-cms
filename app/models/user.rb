# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i[first_name last_name email], using: { tsearch: { prefix: true } }
  has_person_name
  has_secure_token
  has_secure_password
  attr_accessor :current_password

  enum role: { banned: -1, standard: 0, admin: 1 }

  has_many :activities, dependent: :destroy

  before_validation -> { self.email = email.to_s.strip.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :time_zone, presence: true, time_zone: true
  validates :role, presence: true

  scope :matching, ->(term) { search(term) if term.present? }
  scope :with_role, ->(value) { where(role: value) if value.present? }

  def self.authenticate(params)
    user = not_banned.find_by(email: params[:email].to_s.strip.downcase)
    if user
      user if user.authenticate(params[:password])
    else
      new(password: "timing attack")
      nil
    end
  end

  def update_with_password(params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    else
      params[:token] = User.generate_unique_secure_token
    end

    current_password = params.delete(:current_password)
    if authenticate(current_password)
      update(params)
    else
      assign_attributes(params)
      validate
      errors.add(:current_password, :invalid)
      false
    end
  end

  def to_s
    name
  end
end
