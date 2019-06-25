module CocoaCache
  class Command
    def self.run(argv)
      case argv[0]
      when "save"
        CocoaCache::Core.new().save()

      when "restore"
        CocoaCache::Core.new().restore()

      when "--version"
        puts CocoaCache::VERSION

      else
        self.help
      end
    end

    def self.help
      puts "Usage: cocoacache [save|restore]"
    end
  end
end
