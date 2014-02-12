class User
  include Mongoid::Document
  belongs_to: user
end