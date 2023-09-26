class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  has_many :black_list_tokens, dependent: :destroy
end
