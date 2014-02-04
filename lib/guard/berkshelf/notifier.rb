# encoding: utf-8
module Guard
  class Berkshelf
    class Notifier

      def self.guard_message(result, duration)
        case result
        when 'up-to-date'
          "Berkshelf already up-to-date"
        when 'berkshelf_check_install'
          "Berkshelf installed using local gems"
        when true
          "Berkshelf has been installed\nin %.1f seconds." % [duration]
        else
          "Berkshelf can't be installed,\nplease check manually."
        end
      end

      # failed | success
      def self.guard_image(result)
        icon = if result
          :success
        else
          :failed
        end
      end

      def self.notify(result, duration)
        message = guard_message(result, duration)
        image   = guard_image(result)

        ::Guard::Notifier.notify(message, title: 'berks install', image: image)
      end

    end
  end
end
