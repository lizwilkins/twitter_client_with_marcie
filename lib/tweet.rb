class Tweet
end

 # def self.create(options)
 #    post_response = Faraday.post do |request|
 #      request.url 'https://api.github.com/gists'
 #      request.headers['Authorization'] = "Basic " + Base64.encode64("#{$github_username}:#{$github_password}")
 #      request.body = options.to_json
 #    end
 #  end