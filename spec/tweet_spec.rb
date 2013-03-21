require 'spec_helper'

describe Tweet do

  context '#initialize' do
    it 'creates an instance of Tweet with arguments for screen name and text' do
      tweet = Tweet.new(:screen_name => 'twitterapi', :text => 'twitter is neat-o')
      tweet.should be_an_instance_of Tweet
    end
  end

  context 'readers'do
    it 'returns a string for screen_name' do
      tweet = Tweet.new(:screen_name => 'testname', :text => 'test')
      tweet.screen_name.should eq 'testname'
    end

    it 'returns a string for text' do
      tweet = Tweet.new(:screen_name => 'testname', :text => 'test')
      tweet.text.should eq 'test'
    end

  end

  context '==' do
    it 'compares two instances of a Tweet and returns true if they are the same' do
      tweet1 = Tweet.new(:screen_name => 'testname', :text => 'test')
      tweet2 = Tweet.new(:screen_name => 'testname', :text => 'test')
      tweet1.should eq tweet2
    end
  end
end