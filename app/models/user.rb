class User
  include Mongoid::Document
  has_many :messages
  field :name, type: String
end