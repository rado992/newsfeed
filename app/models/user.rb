class User
  include Mongoid::Document
  has_many :messages
  before_create :create_remember_token
  field :name, type: String
  field :password, type: String
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  field :password_digest, type: String
  field :remember_token, type: String
  attr_accessible :name, :password, :password_confirmation
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  public

  @@cipher = Gibberish::AES.new("p4ssw0rd")

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)

  end

  def encrypt
    encoded = @@cipher.enc(password)
    update_attributes(password: encoded)
  end

  def decrypt
    decoded = @@cipher.dec(password)
    update_attributes(password: decoded)
  end
end
