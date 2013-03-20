require './ui_helper'

def welcome
  puts "Welcome to our Twitter Client - prepare to tweet!"
  login
  menu(login_info)
end

def login
  user = User.new
  puts 'To use TwitCommandLine, you need to grant access to the app.'
  puts 'Press enter to launch your web browser and grant access.'
  gets
  user.authorize_url
  puts 'Copy the PIN provided on the page and enter below; press ENTER:'
  user.get_access_token(gets.chomp)

  # print "\nUsername:  "
  # username = gets.chomp
  # print "Password:  "
  # password = STDIN.noecho(&:gets).chomp
  # puts ''
  # user = User.new({:username => 'marcie_mo', :password => 'Ep1c0dus'})
  # user.login
  # if user.success?
  #   {:username => 'marcie_mo', :password => 'Ep1c0dus'}
  # else
  #   puts "Authentification failed due to:"
  #   user.errors.each {|error| puts error.text}
  # end
end 

def menu(login_info)
  puts "What would you like to do? Choose one of the following options."
  puts "'l' to list your followers, to list 'u' who you follow, 'f' to add people to follow, 't' to post a tweet, 's' to show your Twitter feed."
  puts "'x' to exit."
  choice = nil
  until choice == 'x'
    case choice = gets.chomp
    when 'l'
      followers(login_info)
    when 'u'
      following(login_info)
    when 'f'
      new_follower(login_info)
    when 't'
      tweet(login_info)
    when 's'
      twitter_feed(login_info)
    else
    end
  end
end

def followers(login_info)
  puts "Here are your current followers:"
  followers = twitter.list_followers
end

def following(login_info)
  puts "Here who you are following:"
  following = twitter.list_following
end

def new_follower(login_info)
  following(login_info)
  print "Who do you want to add:  "
  user = get.chomp
end

def twitter_feed(login_info)
  puts "\nHere is your twitter feed:"
  print "\n#{twitter_handle} "
  puts tweet.message
end

def tweet(login_info)
  print "Compose new tweet:  "
  tweet = Tweet.new(gets.chomp)
  print "Review new tweet:  "
  puts tweet.message
  print "Send tweet (y/n):  "
  if gets.chomp == 'y'
    tweet.send_tweet
    if tweet.success?
      puts "Tweet posted."
    else
      puts "Tweet post failed due to..."
      tweet.errors.each {|error| puts error.text}
    end
  end
end

welcome