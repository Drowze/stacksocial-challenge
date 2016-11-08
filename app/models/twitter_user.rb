class TwitterUser
  include ActiveModel::Model
  attr_accessor :name, :screen_name

  CONNECTION = $twitter

  def self.find(id)
    raw_user = CONNECTION.user(id)
    new(name: raw_user.name, screen_name: raw_user.screen_name)
  end

  def tweets(limit: 25)
    raw_timeline = CONNECTION.user_timeline(screen_name, count: limit)
    raw_timeline.map { |tweet| Tweet.new(text: tweet.full_text, created_at: tweet.created_at) }
  end
end