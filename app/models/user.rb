class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  normalizes :email, with: ->(email) { email.strip.downcase } # normalizes email to downcase after update or create

  has_many :black_list_tokens, dependent: :destroy
  has_many :articles, dependent: :destroy
end
