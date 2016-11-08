class Tweet
  include ActiveModel::Model
  attr_accessor :text, :created_at
end