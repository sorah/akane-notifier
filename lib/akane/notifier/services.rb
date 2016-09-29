module Akane
  module Notifier
    module Services
      def self.find(name)
        class_name = name.gsub(/(?:\A|_)(.)/) { $1.upcase }

        retried = false
        begin
          return Akane::Notifier::Services.const_get(class_name, false)
        rescue NameError => e
          raise e if retried
          retried = true
          require "akane/notifier/services/#{name}"
          retry
        end
      end
    end
  end
end
