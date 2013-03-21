require 'spec_helper'

describe User do 
  context '#initialize' do 
    it 'initalizes an instance of User with request token' do
      stub = stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub.should have_been_requested
    end
  end

  context '#authorize_url' do 
    it 'launches the web browser' do
      stub = stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      user.authorize_url.should be_true
    end
  end

  context '#get_access_token' do 
    it 'gets the access token' do
      stub = stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new

      stub2 = stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")    
      user.get_access_token(23423432).should_not be_nil
    end
  end

  # context '#add_friend' do 
  #   it 'gets the access token' do
  #     user.add_friend("screen name")
  #   end
  # end

  # context '#initialize' do
  #   it 'create an instance of Tweep with argument screen name' do
  #     stub = stub_request(:post, "https://api.twitter.com/oauth/request_token").
  #       to_return(:body => "oauth_token=t&oauth_token_secret=s")
  #     user = User.new
      
  #     response = Tweep.new(user, 'DeedleTweep')
  #     stub.should have_been_requested
  #     # response1 = access_token.post("https://api.twitter.com/1.1/friendships/create.json?screen_name=#{screen_name}&follow=true")

  #     # output = JSON.parse(response.body)
  #     # output['errors'].length.should be_nil
  #   end
  # end

end

# stub_request(:post, "https://api.twitter.com/oauth/request_token").
#   to_return(:body => "oauth_token=t&oauth_token_secret=s")
 

# stub = stub_request(:post, "https://#{ACCOUNT_SID}:#{AUTH_TOKEN}@api.twilio.com/2010-04-01/Accounts/#{ACCOUNT_SID}/SMS/Messages.json").with(:body => URI.encode_www_form('From' => from, 'To' => to, 'Body' => body))
#       user = User.create(:from => from, :to => to, :body => body)
#       sent_message.should be_an_instance_of Message



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
