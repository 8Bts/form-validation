class Author < ApplicationRecord
  include ActiveModel::Validations

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email format' }

  def to_s
    "first_name=#{first_name}&last_name=#{last_name}"
  end
end
