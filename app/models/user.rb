# frozen_string_literal: true

class User < ApplicationRecord
  has_person_name
  has_secure_token
  has_secure_password
  enum role: { banned: -1, standard: 0, admin: 1 }

  before_validation -> { self.email = email.to_s.strip.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :time_zone, presence: true, time_zone: true
  validates :role, presence: true

  def self.authenticate(params)
    user = not_banned.find_by(email: params[:email].to_s.strip.downcase)
    if user
      user if user.authenticate(params[:password])
    else
      new(password: "timing attack")
      nil
    end
  end
end
