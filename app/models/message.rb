class Message
  include Mongoid::Document
  belongs_to :user
  field :content, type: String
  field :likes, type: Integer
  attr_accessible :content, :likes
  validates_presence_of :content
end