class User
  include Mongoid::Document
  belongs_to :user
  field :content, type: String
  field :likes, type: Integer
end