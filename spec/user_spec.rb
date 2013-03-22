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
    it 'creates a new friendship between the user and another user with screen_name as an argument' do
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

  context '#tweet' do
    it 'updates the user status (posts a new tweet)' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub = stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
         with(:body => {"status"=>"test"})
      user.tweet('test')
      stub.should have_been_requested
    end

    it 'returns true if tweet is successfully posted' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
         with(:body => {"status"=>"test"}).to_return(:status => 200)
      user.tweet('test').should be_true
    end

    it 'returns false if tweet is not posted' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
         with(:body => {"status"=>"test"}).to_return(:status => 401)
      user.tweet('test').should be_false
    end
  end

  context 'twitter_feed' do
    it 'returns a collection of the most recent Tweets and retweets posted by the user and the users they follow' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub = stub_request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json").to_return(:body => "[{\"created_at\":\"Thu Mar 21 19:05:01 +0000 2013\",\"id\":314814925266644992,\"id_str\":\"314814925266644992\",\"text\":\"i made breakfast!\",\"source\":\"\\u003ca href=\\\"http:\\/\\/www.tweetdeck.com\\\" rel=\\\"nofollow\\\"\\u003eTweetDeck\\u003c\\/a\\u003e\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":132984721,\"id_str\":\"132984721\",\"name\":\"FRA Conferences\",\"screen_name\":\"twitterapi\",\"location\":\"Bicoastal\",\"description\":\"Offering highly targeted conferences and events, Financial Research Associates (FRA) provides access to business information and networking opportunities.\",\"url\":\"http:\\/\\/www.frallc.com\",\"entities\":{\"url\":{\"urls\":[{\"url\":\"http:\\/\\/www.frallc.com\",\"expanded_url\":null,\"indices\":[0,21]}]},\"description\":{\"urls\":[]}},\"protected\":false,\"followers_count\":909,\"friends_count\":1830,\"listed_count\":12,\"created_at\":\"Wed Apr 14 18:13:12 +0000 2010\",\"favourites_count\":18,\"utc_offset\":-18000,\"time_zone\":\"Eastern Time (US & Canada)\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":2407,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"8CB3DB\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/797529396\\/f6bdb4a2b7b25728ca8a45c95e3595d8.png\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/797529396\\/f6bdb4a2b7b25728ca8a45c95e3595d8.png\",\"profile_background_tile\":false,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/1264992299\\/fra_73x73_normal.png\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/1264992299\\/fra_73x73_normal.png\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/132984721\\/1357682586\",\"profile_link_color\":\"0A85FF\",\"profile_sidebar_border_color\":\"FFFFFF\",\"profile_sidebar_fill_color\":\"AACAEB\",\"profile_text_color\":\"0E3D54\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":true,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"retweet_count\":0,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[{\"url\":\"http:\\/\\/t.co\\/IVA4XzB5Ki\",\"expanded_url\":\"http:\\/\\/www.frallc.com\\/pdf\\/B870.pdf\",\"display_url\":\"frallc.com\\/pdf\\/B870.pdf\",\"indices\":[60,82]}],\"user_mentions\":[]},\"favorited\":false,\"retweeted\":false,\"possibly_sensitive\":false,\"lang\":\"en\"},{\"created_at\":\"Thu Mar 21 19:02:28 +0000 2013\",\"id\":314814281545826304,\"id_str\":\"314814281545826304\",\"text\":\"epicodus is fun\",\"source\":\"\\u003ca href=\\\"http:\\/\\/www.tweetdeck.com\\\" rel=\\\"nofollow\\\"\\u003eTweetDeck\\u003c\\/a\\u003e\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":132984721,\"id_str\":\"132984721\",\"name\":\"FRA Conferences\",\"screen_name\":\"michael\",\"location\":\"Bicoastal\",\"description\":\"Offering highly targeted conferences and events, Financial Research Associates (FRA) provides access to business information and networking opportunities.\",\"url\":\"http:\\/\\/www.frallc.com\",\"entities\":{\"url\":{\"urls\":[{\"url\":\"http:\\/\\/www.frallc.com\",\"expanded_url\":null,\"indices\":[0,21]}]},\"description\":{\"urls\":[]}},\"protected\":false,\"followers_count\":909,\"friends_count\":1830,\"listed_count\":12,\"created_at\":\"Wed Apr 14 18:13:12 +0000 2010\",\"favourites_count\":18,\"utc_offset\":-18000,\"time_zone\":\"Eastern Time (US & Canada)\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":2407,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"8CB3DB\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/797529396\\/f6bdb4a2b7b25728ca8a45c95e3595d8.png\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/797529396\\/f6bdb4a2b7b25728ca8a45c95e3595d8.png\",\"profile_background_tile\":false,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/1264992299\\/fra_73x73_normal.png\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/1264992299\\/fra_73x73_normal.png\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/132984721\\/1357682586\",\"profile_link_color\":\"0A85FF\",\"profile_sidebar_border_color\":\"FFFFFF\",\"profile_sidebar_fill_color\":\"AACAEB\",\"profile_text_color\":\"0E3D54\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":true,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"retweeted_status\":{\"created_at\":\"Wed Mar 20 17:17:51 +0000 2013\",\"id\":314425568131166208,\"id_str\":\"314425568131166208\",\"text\":\"Register Today for @FRAConferences\\u2019 Building the Better Family Office Summit in NYC! Discount code FMP173: http:\\/\\/t.co\\/mg1mA2vbR9\",\"source\":\"\\u003ca href=\\\"http:\\/\\/www.tweetdeck.com\\\" rel=\\\"nofollow\\\"\\u003eTweetDeck\\u003c\\/a\\u003e\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":45670056,\"id_str\":\"45670056\",\"name\":\"Jack Kelly\",\"screen_name\":\"HedgeFundsX\",\"location\":\"New York\",\"description\":\"Hedge Fund News Blog\",\"url\":\"http:\\/\\/hedgefundsx.com\\/\",\"entities\":{\"url\":{\"urls\":[{\"url\":\"http:\\/\\/hedgefundsx.com\\/\",\"expanded_url\":null,\"indices\":[0,23]}]},\"description\":{\"urls\":[]}},\"protected\":false,\"followers_count\":3703,\"friends_count\":1071,\"listed_count\":121,\"created_at\":\"Mon Jun 08 21:02:58 +0000 2009\",\"favourites_count\":1,\"utc_offset\":-18000,\"time_zone\":\"Quito\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":2083,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"1D2E21\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/784713909\\/ddbbc85cd1e3605e0f9b545aef4e5e14.jpeg\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/784713909\\/ddbbc85cd1e3605e0f9b545aef4e5e14.jpeg\",\"profile_background_tile\":true,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/3396467929\\/e0256bed87f199b4e846d8533d0104d0_normal.jpeg\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/3396467929\\/e0256bed87f199b4e846d8533d0104d0_normal.jpeg\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/45670056\\/1360267275\",\"profile_link_color\":\"176E17\",\"profile_sidebar_border_color\":\"FFFFFF\",\"profile_sidebar_fill_color\":\"86AD75\",\"profile_text_color\":\"0F0E0F\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":null,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"retweet_count\":1,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[{\"url\":\"http:\\/\\/t.co\\/mg1mA2vbR9\",\"expanded_url\":\"http:\\/\\/bit.ly\\/VbpkBL\",\"display_url\":\"bit.ly\\/VbpkBL\",\"indices\":[107,129]}],\"user_mentions\":[{\"screen_name\":\"FRAConferences\",\"name\":\"FRA Conferences\",\"id\":132984721,\"id_str\":\"132984721\",\"indices\":[19,34]}]},\"favorited\":false,\"retweeted\":false,\"possibly_sensitive\":false,\"lang\":\"en\"},\"retweet_count\":1,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[],\"user_mentions\":[{\"screen_name\":\"HedgeFundsX\",\"name\":\"Jack Kelly\",\"id\":45670056,\"id_str\":\"45670056\",\"indices\":[3,15]},{\"screen_name\":\"FRAConferences\",\"name\":\"FRA Conferences\",\"id\":132984721,\"id_str\":\"132984721\",\"indices\":[36,51]}]},\"favorited\":false,\"retweeted\":false,\"lang\":\"en\"}]")
      user.twitter_feed.should eq [Tweet.new(:screen_name => 'twitterapi', :text => 'i made breakfast!'), Tweet.new(:screen_name => 'michael', :text => 'epicodus is fun')]
    end
  end

  context 'following_list' do
    it 'returns a list of friends who the user is following' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub = stub_request(:get, "https://api.twitter.com/1.1/friends/list.json").
         to_return(:status => 200, :body => "{\"users\":[{\"id\":499237034,\"id_str\":\"499237034\",\"name\":\"SAHABAT\",\"screen_name\":\"twitterapi\",\"location\":\"\",\"url\":null,\"description\":\"Contact management -  EYANG : 0878 - 7792 - 2666  @kerentpagustian \",\"protected\":false,\"followers_count\":486,\"friends_count\":20,\"listed_count\":0,\"created_at\":\"Tue Feb 21 22:38:49 +0000 2012\",\"favourites_count\":0,\"utc_offset\":28800,\"time_zone\":\"Beijing\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":13,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"F50AF5\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/818313277\\/effa0c0a6419dcbde8182141791d7c46.jpeg\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/818313277\\/effa0c0a6419dcbde8182141791d7c46.jpeg\",\"profile_background_tile\":true,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/3399038303\\/dd973ff9573aa081efc5229e139c41c8_normal.jpeg\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/3399038303\\/dd973ff9573aa081efc5229e139c41c8_normal.jpeg\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/499237034\\/1363661585\",\"profile_link_color\":\"FF0000\",\"profile_sidebar_border_color\":\"000000\",\"profile_sidebar_fill_color\":\"7AC3EE\",\"profile_text_color\":\"3D1957\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":false,\"follow_request_sent\":false,\"notifications\":false},{\"id\":25155303,\"id_str\":\"25155303\",\"name\":\"Bless\",\"screen_name\":\"michael\",\"location\":\"Cape Town\",\"url\":\"http:\\/\\/bit.ly\\/KT4fF9\",\"description\":\"Today is The Day!!!\",\"protected\":false,\"followers_count\":11971,\"friends_count\":10400,\"listed_count\":75,\"created_at\":\"Wed Mar 18 21:09:29 +0000 2009\",\"favourites_count\":989,\"utc_offset\":7200,\"time_zone\":\"Pretoria\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":112590,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"000000\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/812712396\\/a26f9d46cff9a4ab187d723800d61cb7.jpeg\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/812712396\\/a26f9d46cff9a4ab187d723800d61cb7.jpeg\",\"profile_background_tile\":true,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/3383333246\\/fe79f779d6cf3172bfc3bf465afd4140_normal.jpeg\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/3383333246\\/fe79f779d6cf3172bfc3bf465afd4140_normal.jpeg\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/25155303\\/1363072116\",\"profile_link_color\":\"B08D00\",\"profile_sidebar_border_color\":\"FFFFFF\",\"profile_sidebar_fill_color\":\"EFEFEF\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":false,\"follow_request_sent\":false,\"notifications\":false}],\"next_cursor\":1430104070717225887,\"next_cursor_str\":\"1430104070717225887\",\"previous_cursor\":0,\"previous_cursor_str\":\"0\"}")
      user.following_list.should eq [Friend.new(:screen_name => 'twitterapi'), Friend.new(:screen_name => 'michael')]
    end
  end

  context 'followed_by_list' do
    it 'returns a list of friends who are following the user' do
      stub_request(:post, "https://api.twitter.com/oauth/request_token").
        to_return(:body => "oauth_token=t&oauth_token_secret=s")    
      user = User.new
      stub_request(:post, "https://api.twitter.com/oauth/access_token").
        to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
      user.get_access_token(23423432)
      stub = stub_request(:get, "https://api.twitter.com/1.1/followers/list.json").
         to_return(:status => 200, :body => "{\"users\":[{\"id\":499237034,\"id_str\":\"499237034\",\"name\":\"SAHABAT\",\"screen_name\":\"twitterapi\",\"location\":\"\",\"url\":null,\"description\":\"Contact management -  EYANG : 0878 - 7792 - 2666  @kerentpagustian \",\"protected\":false,\"followers_count\":486,\"friends_count\":20,\"listed_count\":0,\"created_at\":\"Tue Feb 21 22:38:49 +0000 2012\",\"favourites_count\":0,\"utc_offset\":28800,\"time_zone\":\"Beijing\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":13,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"F50AF5\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/818313277\\/effa0c0a6419dcbde8182141791d7c46.jpeg\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/818313277\\/effa0c0a6419dcbde8182141791d7c46.jpeg\",\"profile_background_tile\":true,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/3399038303\\/dd973ff9573aa081efc5229e139c41c8_normal.jpeg\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/3399038303\\/dd973ff9573aa081efc5229e139c41c8_normal.jpeg\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/499237034\\/1363661585\",\"profile_link_color\":\"FF0000\",\"profile_sidebar_border_color\":\"000000\",\"profile_sidebar_fill_color\":\"7AC3EE\",\"profile_text_color\":\"3D1957\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":false,\"follow_request_sent\":false,\"notifications\":false},{\"id\":25155303,\"id_str\":\"25155303\",\"name\":\"Bless\",\"screen_name\":\"michael\",\"location\":\"Cape Town\",\"url\":\"http:\\/\\/bit.ly\\/KT4fF9\",\"description\":\"Today is The Day!!!\",\"protected\":false,\"followers_count\":11971,\"friends_count\":10400,\"listed_count\":75,\"created_at\":\"Wed Mar 18 21:09:29 +0000 2009\",\"favourites_count\":989,\"utc_offset\":7200,\"time_zone\":\"Pretoria\",\"geo_enabled\":false,\"verified\":false,\"statuses_count\":112590,\"lang\":\"en\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"000000\",\"profile_background_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_background_images\\/812712396\\/a26f9d46cff9a4ab187d723800d61cb7.jpeg\",\"profile_background_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_background_images\\/812712396\\/a26f9d46cff9a4ab187d723800d61cb7.jpeg\",\"profile_background_tile\":true,\"profile_image_url\":\"http:\\/\\/a0.twimg.com\\/profile_images\\/3383333246\\/fe79f779d6cf3172bfc3bf465afd4140_normal.jpeg\",\"profile_image_url_https\":\"https:\\/\\/si0.twimg.com\\/profile_images\\/3383333246\\/fe79f779d6cf3172bfc3bf465afd4140_normal.jpeg\",\"profile_banner_url\":\"https:\\/\\/si0.twimg.com\\/profile_banners\\/25155303\\/1363072116\",\"profile_link_color\":\"B08D00\",\"profile_sidebar_border_color\":\"FFFFFF\",\"profile_sidebar_fill_color\":\"EFEFEF\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"default_profile\":false,\"default_profile_image\":false,\"following\":false,\"follow_request_sent\":false,\"notifications\":false}],\"next_cursor\":1430104070717225887,\"next_cursor_str\":\"1430104070717225887\",\"previous_cursor\":0,\"previous_cursor_str\":\"0\"}")
      user.followed_by_list.should eq [Friend.new(:screen_name => 'twitterapi'), Friend.new(:screen_name => 'michael')]
    end
  end

end







