require './ui_helper'

def welcome
  puts "Welcome to command line Twitter!"
  user = login
  menu(user)
end

def login
  user = User.new
  puts "\nTo use TwitCommandLine, you need to grant access to the app."
  puts 'Press enter to launch your web browser and grant access.'
  gets
  Launchy.open user.authorize_url
  puts 'Copy the PIN provided on the page and enter it below; then press ENTER:'
  user.get_access_token(gets.chomp)
  user
end 

def menu(user)
  puts "\nWhat would you like to do? Choose from the following options."
  puts "'t' to post a tweet, 'v' to view your Twitter feed, 'a' to add a new follow, 'l' to list your followers, 'u' to list who you follow"
  puts "'x' to exit"
  choice = nil
  until choice == 'x'
    case choice = gets.chomp
    when 't'
      print "\nCompose new tweet:  "
      message = gets.chomp
      print "Review new tweet:  "
      puts message
      print "Send tweet (y/n):  "
      if gets.chomp == 'y'
        # tweet = Tweet.new(:screen_name => user.screen_name, :text => message)
        tweet = user.tweet(message)
        if tweet != nil
          puts "Tweet posted."
        else
          puts "Tweet post failed. Sorry."
          # tweet.errors.each {|error| puts error.text}
        end
      else
      end
    when 'v'
      puts "\nHere is your twitter feed:"
      tweets = user.twitter_feed
      tweets.each {|tweet| puts "\n#{tweet.screen_name}  #{tweet.text}"}
    when 'a'
      print "\nWho do you want to add:  "
      screen_name = gets.chomp
      tweep = user.add_friend(screen_name)
      if tweep != nil
        puts "#{screen_name} has been added to your following."
      else
        puts "#{screen_name} was not added. Sorry."
        # tweep.errors.each {|error| puts error.text}
      end
    when 'l'
      puts "\nHere are your current followers:"
      followers = user.followed_by_list
      followers.each {|follower| puts "\n#{follower.screen_name}"
    when 'u'
      puts "\nHere's who you are following:"
      followers = user.following_list
      followers.each {|follower| puts "\n#{follower.screen_name}"
    else
    end
  end
end

welcome
