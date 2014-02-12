class User
  include Mongoid::Document
  has_many :messages
  field :username, type: String
  field :password, type: String
  field :muted, type: Array
  attr_accessible :username, :password, :muted
  validates_presence_of :username, :password
end