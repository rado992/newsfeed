class User
  include Mongoid::Document
  has_many :messages
  # include BCrypt
  # include ActiveModel::SecurePassword
  before_create :create_remember_token
  #validate :passwords_same
  field :name, type: String
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  #validates_presence_of :password, :password_confirmation
  # uniqueness: {case_sensitive: false}
  # index({ ssn: 1 }, { unique: true, name: "ssn_index" })
  # include ActiveModel::SecurePassword
  field :password_digest, type: String
  field :remember_token, type: String
  # validates :password_digest, presence: true, length: {minimum: 5}
  # has_secure_password
  attr_accessible :name, :password, :password_confirmation
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def passwords_same
    password == password_confirmation
  end
end
