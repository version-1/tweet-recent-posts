class Twitter
    def initialize(config)
        consumer = OAuth::Consumer.new(
          config['consumer_key'],
          config['consumer_secret'],
          site:'https://api.twitter.com/'
        )
        @endpoint = OAuth::AccessToken.new(consumer, config['access_token'], config['access_token_secret'])
    end

    def tweet(message)
        if @endpoint.nil?
            raise 'no endpoint..'
        end
        response = @endpoint.post('https://api.twitter.com/1.1/statuses/update.json', status: message)
        return JSON.parse(response.body)
    end
end
