require 'logger'

require 'akane/util'
require 'akane/storages/abstract_storage'

require 'akane/notifier/version'
require 'akane/notifier/services'

module Akane
  module Storages
    class Notifier < AbstractStorage
      class RequestError < StandardError; end

      VERSION = Akane::Notifier::VERSION

      def initialize(config: raise(ArgumentError, 'missing config'), logger: Logger.new($stdout))
        super

        @config["keywords"] ||= []
        @config["screen_names"] ||= []
        @config["excludes"] ||= []
        @config["recipients"]  ||= []

        unless @config["keywords"].kind_of?(Enumerable)
          raise ArgumentError, "config `keywords` should be Enumerable"
        end
        unless @config["excludes"].kind_of?(Enumerable)
          raise ArgumentError, "config `excludes` should be Enumerable"
        end
        unless @config["recipients"].kind_of?(Enumerable)
          raise ArgumentError, "config `recipients` should be Enumerable"
        end

        @config["keywords"] = nil if @config['keywords'].count.zero?

        @recipients = @config['recipients'].flat_map do |definition|
          definition.map do |kind, conf|
            Akane::Notifier::Services.find(kind).new(logger: logger, **Akane::Util.symbolish_hash(conf))
          end
        end
        if @config['match_ruby']
          singleton_class.class_eval("def match_method(tweet)\n#{[*@config['match_ruby']].map { |_|  "(#{_})" }.join(" || ") }\nend")
          @match_method = true
        end
      end

      def record_tweet(account, tweet)
        return unless match_rule?(tweet)

        @logger.info "Firing notification of #{tweet.url.to_s}"
        @recipients.each do |recipient|
          recipient.fire(account, tweet)
        end
      end

      def mark_as_deleted(*)
      end

      def record_event(*)
      end

      def record_message(*)
      end

      private

      def match_rule?(tweet)
        tweet.text &&
        !tweet.retweet? &&
        @config["excludes"].all? { |_| ! tweet.text.include?(_.to_s) } &&
        (
          (@config['keywords'] && @config["keywords"].any? { |_| tweet.text.include?(_.to_s) }) ||
          @config["screen_names"].include?(tweet.user.screen_name) ||
          (@match_method && match_method(tweet))
        )
      end
    end
  end
end
