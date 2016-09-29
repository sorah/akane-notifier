require 'logger'

module Akane
  module Notifier
    module Services
      class Base
        def initialize(logger: nil)
          @logger = logger || Logger.new($stdout)
        end

        def fire(account, tweet)
        end
      end
    end
  end
end
