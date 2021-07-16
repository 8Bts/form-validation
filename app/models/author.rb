class Author
  include ActiveModel::Validations
  attr_accessor :first_name, :last_name, :email

  def initialize(params = {})
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
  end

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email format' }

  def to_s
    "first_name=#{first_name}&last_name=#{last_name}"
  end
end
