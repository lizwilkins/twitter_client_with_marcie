require 'spec_helper'

describe User do 
  context 'initialize' do 
    it 'initalizes an instance of User' do
      stub = stub_request(:post, "https://api.twitter.com/oauth/request_token").
         with(:headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth oauth_body_hash="2jmj7l5rSw0yVb%2FvlWAYkK%2FYBwk%3D", oauth_callback="oob", oauth_consumer_key="LGdEp6Kbk1rwFTzvyRgUyw", oauth_nonce="5Ckrh5Q3vp51XXJWtm5v5EJnjOqWJaIQi9Q2NGCXwsM", oauth_signature="eHfveh7ATSLB49hiBXa6Hfw8e4M%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1363808806", oauth_version="1.0"', 'Content-Length'=>'0', 'User-Agent'=>'OAuth gem v0.4.7'}).
         to_return(:status => 200, :body => "", :headers => {})

      stub =
      User.new.should be_an_instance_of User
      stub = 

      stub = stub_request(:post, "https://#{ACCOUNT_SID}:#{AUTH_TOKEN}@api.twilio.com/2010-04-01/Accounts/#{ACCOUNT_SID}/SMS/Messages.json").with(:body => URI.encode_www_form('From' => from, 'To' => to, 'Body' => body))
      user = User.create(:from => from, :to => to, :body => body)
      sent_message.should be_an_instance_of Message



    end
  end

end

# stub_request(:post, "https://api.twitter.com/oauth/request_token").
#   to_return(:body => "oauth_token=t&oauth_token_secret=s")
 
# stub_request(:post, "https://api.twitter.com/oauth/access_token").
#   to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")

 # context 'accessors' do 
 #    it 'returns the string for username' do
 #      user = User.new({:username => 'Epicodus', :password => 'Epicodus'})
 #      user.username.should eq 'Epicodus'
 #    end

 #    it 'returns the string for password' do
 #      user = User.new({:username => 'Epicodus', :password => 'Epicodus'})
 #      user.password.should eq 'Epicodus'
 #    end

 #  end

 #  context 'login' do 
 #    it 'authenticates the user credentials' do
 #      user = User.new({:username => 'Epicodus', :password => 'Epicodus'})
 #      user.username.should eq 'Epicodus'
 #    end

 #    it 'returns the string for password' do
 #      user = User.new({:username => 'Epicodus', :password => 'Epicodus'})
 #      user.password.should eq 'Epicodus'
 #    end

 #  end
