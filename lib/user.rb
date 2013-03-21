class User

  attr_accessor :consumer, :request_token, :access_token

  def initialize
    @consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com/")
    @request_token = @consumer.get_request_token(:oauth_callback => CALLBACK_URL)
  end

  def authorize_url
    @request_token.authorize_url(:oauth_callback => CALLBACK_URL)
  end

  def get_access_token(oauth_verifier)
    @access_token = @request_token.get_access_token(:oauth_verifier => oauth_verifier)
  end

  def add_friend(screen_name)
    response = @access_token.post("https://api.twitter.com/1.1/friendships/create.json?screen_name=#{screen_name}&follow=true")
  end

  def tweet(message)
    response = access_token.post("https://api.twitter.com/1.1/statuses/update.json", {:status => message})
    response.code == "200"
  end

  # def twitter_feed
  #   timeline = access_token.get("https://api.twitter.com/1.1/statuses/home_timeline.json")
  #   tweets = JSON.parse(timeline.body)
  #   tweets.map {|tweet| Tweet.new(tweet['screen_name'], tweet['text'])}
  # end

end