module Fastlane
  module Helper
    class HoursHelper
      # class methods that you define here become available in your action
      # as `Helper::HoursHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the hours plugin helper!")
      end
    end
  end
end
