require 'akane/notifier/services/base'
require 'json'
require 'uri'
require 'net/http'
require 'net/https'

module Akane
  module Notifier
    module Services
      class Slack < Base
        def initialize(webhook_url: , logger: nil)
          super(logger: logger)
          @webhook_url = URI.parse(webhook_url)
        end

        def fire(account, tweet)
          Net::HTTP.post_form(
            @webhook_url,
            payload: {
              text: tweet.url.to_s,
            }.to_json
          )
        end
      end
    end
  end
end
