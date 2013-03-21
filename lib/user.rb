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
    response = @access_token.post("https://api.twitter.com/1.1/statuses/update.json", {:status => message})
    response.code == "200"
  end

  def twitter_feed
    timeline = @access_token.get("https://api.twitter.com/1.1/statuses/home_timeline.json")
    tweets = JSON.parse(timeline.body)
    tweets.map {|tweet| Tweet.new(:screen_name => tweet['user']['screen_name'], :text => tweet['text'])}
  end

  def following_list
    puts "hi"
    p followers = @access_token.get("https://api.twitter.com/1.1/followers/list.json?cursor=-1&screen_name=marciemo&skip_status=true&include_user_entities=false")
    p friends = JSON.parse(followers.body)
    friends.map {|friend| Friend.new(:screen_name => friend['users']['screen_name'])}
  end

  def followed_by_list

  end

end