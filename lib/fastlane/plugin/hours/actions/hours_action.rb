# require 'pry'
module Fastlane
  module Actions
    class HoursAction < Action
      def self.run(params)
        # UI.message("The hours plugin is working!")
        start_timing = params[:start_timing]
        if start_timing
          puts "Start time: "
          puts Time.now
          started_time = Time.now
          ENV["Start_time"] = started_time.to_s
        end

        measure_timing = params[:measure_timing]
        if measure_timing
          puts "End Time: "
          puts Time.now
          started_time = Time.parse(ENV["Start_time"])
          duration = Time.now - started_time
          existing_duration = 0
          file = File.open("save_duration.txt", "a+")
          existing_duration = file.read.to_i
          File.open("save_duration.txt", 'w+') do |f|
            duration += existing_duration
            f.puts(duration)
          end
          duration_minutes = (duration / 60.0).round
          if duration_minutes == 0
            UI.success "Total time saved #{duration.round} seconds till now 🎉"
          elsif duration_minutes >= 60
            duration_hours = (duration_minutes / 60.0).round
            if duration_hours == 1
              UI.success "Total time saved #{duration_hours} hour till now 🎉"
            else
              UI.success "Total time saved #{duration_hours} hours till now 🎉"
            end
          else
            UI.success "Total time saved #{duration_minutes} minutes till now 🎉"
          end

        end
      end

      def self.description
        "Record total time saved by fastlane"
      end

      def self.authors
        ["@RishabhTayal"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        [
          "This action will calculate the total time saved for your project and save the save_duration.txt in `fastlane` folder."
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :start_timing,
                                  env_name: "HOURS_START_TIMING",
                               description: "Starts recording time. Set this to `true` in `before_all` block",
                                  optional: false,
                                  is_string: false,
                                  default_value: false),
          FastlaneCore::ConfigItem.new(key: :measure_timing,
                                  env_name: "HOURS_MEASURE_TIMING",
                               description: "Calculates the total time taken for this lane. Set this to `true` in `after_all` block",
                                  optional: false,
                                  is_string: false,
                                  default_value: false)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
