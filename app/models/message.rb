class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  field :content, type: String
  field :likes, type: Integer, default: 0
  attr_accessible :content, :likes
  validates_presence_of :content
end