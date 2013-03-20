class User

  attr_accessor :consumer, :request_token, :access_token

  def initialize
    @consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com/")
    @request_token = consumer.get_request_token(:oauth_callback => CALLBACK_URL)
  end

  def authorize_url
    Launchy.open @request_token.authorize_url(:oauth_callback => CALLBACK_URL)
  end

  def get_access_token(oauth_verifier)
    @access_token = @request_token.get_access_token(:oauth_verifier => oauth_verifier)
  end
end



 # def self.create(options)
 #    post_response = Faraday.post do |request|
 #      request.url 'https://api.github.com/gists'
 #      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
 #      request.body = options.to_json
 #    end
 #  end

 #  http://api.twitter.com/1/account/verify_credentials.format
