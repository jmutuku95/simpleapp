class User < ApplicationRecord
  attr_accessor :activation_token, :remember_token, :reset_token
  before_create :create_activation_digest
  after_create :send_activation_email
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  # use conditional validation check if persisted
  validates :password, presence: true, length: { minimum: 6 },
                       allow_nil: true, if: :persisted?

  scope :active, -> { where(activated: true) }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Will returns true if the given a token matching the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate!
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self, activation_token).deliver_later
  end

  def create_reset_digest!
    self.reset_token = User.new_token
    update_attributes(
      reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
    )
    send_password_reset_email
  end

  def password_reset_token_expired?
    reset_sent_at < 1.hour.ago
  end

  private

  def send_password_reset_email
    UserMailer.password_reset(self, reset_token).deliver_later
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
