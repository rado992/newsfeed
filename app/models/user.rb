class User
  include Mongoid::Document
  has_many: messages
end