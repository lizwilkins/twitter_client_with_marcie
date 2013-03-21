require './ui_helper'

def welcome
  puts "Welcome to our Twitter Client - prepare to tweet!"
  user = login
  menu(user)
end

def login
  user = User.new
  puts "\nTo use TwitCommandLine, you need to grant access to the app."
  puts 'Press enter to launch your web browser and grant access.'
  gets
  user.authorize_url
  puts 'Copy the PIN provided on the page and enter below; press ENTER:'
  user.get_access_token(gets.chomp)
  user
end 

def menu(user)
  puts "\nWhat would you like to do? Choose one of the following options."
  puts "'l' to list your followers, to list 'u' who you follow, 'f' to add people to follow, 't' to post a tweet, 's' to show your Twitter feed."
  puts "'x' to exit."
  choice = nil
  until choice == 'x'
    case choice = gets.chomp
    when 'l'
      puts "\nHere are your current followers:"
      followers = user.followers
      followers.each {|follower| puts follower.screen_name}
    when 'u'
      puts "\nHere's who you are following:"
      followers = user.follow
      followers.each {|follower| puts follower.screen_name}
    when 'f'
      print "\nWho do you want to add:  "
      screen_name = gets.chomp
      tweep = user.add_friend(screen_name)
      if tweep != nil
        puts "#{tweep.name} has been added to your following."
      else
        puts "#{handle} was not added due to..."
        tweep.errors.each {|error| puts error.text}
      end
    when 't'
      print "\nCompose new tweet:  "
      message = gets.chomp
      print "Review new tweet:  "
      puts message
      print "Send tweet (y/n):  "
      if gets.chomp == 'y'
        errors = user.tweet(message)
        if errors == nil
          puts "Tweet posted."
        else
          puts "Tweet post failed due to..."
          errors.each {|error| puts error.text}
        end
      end
    when 's'
      puts "\nHere is your twitter feed:"
      tweets = user.twitter_feed
      tweets.each {|tweet| puts "\n#{twitter_handle}  #{tweet.message}"}
    else
    end
  end
end

welcome
