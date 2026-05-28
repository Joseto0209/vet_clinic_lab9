class Owner < ApplicationRecord
  has_many :pets
  belongs_to :user, optional: true

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :phone, presence: true

  # Callbacks - normalize email before validation
  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end
end