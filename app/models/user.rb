class User
  include Mongoid::Document

  has_many :messages
  before_create :create_remember_token

  field :name, type: String
  field :password, type: String
  field :remember_token, type: String
  field :avatar, type: String
  field :blocks, type: Integer, default: 0
  field :blocked, type: Array, default: []

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, length: { minimum: 4, maximum: 50 }, presence: true

  attr_accessible :name, :password, :avatar, :blocked

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def encrypt
    cipher = Gibberish::AES.new("p4ssw0rd")
    encoded = cipher.enc(password)
    update_attributes(password: encoded)
    password
  end

  def decrypt
    cipher = Gibberish::AES.new("p4ssw0rd")
    decoded = cipher.dec(password)
    update_attributes(password: decoded)
    password
  end

  def authenticate given_password
    cipher = Gibberish::AES.new("p4ssw0rd")
    given_password == cipher.dec(password)
  end

  private

    def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
