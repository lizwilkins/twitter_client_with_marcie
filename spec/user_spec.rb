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
      user.authorize_url.should eq 'https://api.twitter.com//oauth/authorize?oauth_callback=oob&oauth_token=t'
    end
  end

  context '#get_access_token' do 
    it 'gets the access token' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new

      stub = stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")    
      user.get_access_token(23423432)
      stub.should have_been_requested
    end
  end

  context '#add_friend' do 
    it 'creates a new friendship between the user and screen name that was input in the UI' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub = stub_request(:post, "https://api.twitter.com/1.1/friendships/create.json?follow=true&screen_name=name")
      user.add_friend('name')
      stub.should have_been_requested
    end
  end

  # context '#tweet' do
  #   it 'updates the user status (posts a new tweet)' do
  #     stub_request(:post, "https://api.twitter.com/oauth/request_token").
  #       to_return(:body => "oauth_token=t&oauth_token_secret=s")    
  #     user = User.new
  #     stub_request(:post, "https://api.twitter.com/oauth/access_token").
  #       to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
  #     user.get_access_token(23423432)
  #     stub = stub_request(:post, "https://api.twitter.com/1.1/friendships/create.json?status='test'&in_reply_to_status_id='@marciemo'")
  #     user.tweet('test')
  #     stub.should have_been_requested
  #   end
  # end
end