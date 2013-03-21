require 'spec_helper'

describe Tweet do

  context '#initialize' do
    it 'creates an instance of Tweet with arguments for screen name and text' do
      tweet = Tweet.new(:screen_name => 'twitterapi', :text => 'twitter is neat-o')
      tweet.should be_an_instance_of Tweet
    end
  end
end