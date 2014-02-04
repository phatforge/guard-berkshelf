# encoding: utf-8
require 'guard'
require 'guard/plugin'

module Guard
  class Berkshelf < Plugin
    autoload :Notifier, 'guard/berkshelf/notifier'

    def start
      refresh_berkshelf
    end

    def reload
      refresh_berkshelf
    end

    def run_all
      refresh_berkshelf
    end

    def run_on_additions(paths = [])
      refresh_berkshelf
    end

    def run_on_modifications(paths = [])
      refresh_berkshelf
    end

    def cli?
      !!options[:cli]
    end

    private

    def refresh_berkshelf
      start_at = Time.now
      result = berkshelf_install
      duration = Time.now - start_at
      case result
      when :berkshelf_already_up_to_date
        ::Guard::UI.info 'Berkshelf already up-to-date', reset: true
      when :berkshelf_installed_using_local_gems
        ::Guard::UI.info 'Berkshelf installed using local gems', reset: true
        Notifier.notify 'berkshelf_check_install', nil
      when :berkshelf_installed
        ::Guard::UI.info 'Berkshelf installed', reset: true
        Notifier.notify true, duration
      else
        ::Guard::UI.info "Berkshelf can't be installed -- Please check manually", reset: true
        Notifier.notify false, nil
      end
      result
    end

    

    def berkshelf_install
      system("berks install#{" #{options[:cli]}" if options[:cli]}")
      
      $? == 0 ? :berkshelf_installed : false
    end
  end
end
