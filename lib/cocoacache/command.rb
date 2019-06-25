require "colored2"

module CocoaCache
  class Command
    def self.run(core_factory, argv)
      case argv[0]
      when "save"
        core = self.get_core(core_factory, argv)
        core.save()

      when "restore"
        core = self.get_core(core_factory, argv)
        core.restore()

      when "--version"
        puts CocoaCache::VERSION

      else
        self.help
      end
    end

    def self.get_core(factory, argv)
      return factory.new(
        :origin_specs_dir => (
          self.parse_argument(argv, "--origin") \
          or "$HOME/.cocoapods/repos/master/Specs"
        ),
        :cache_specs_dir => (
          self.parse_argument(argv, "--cache") \
            or "Specs"
        ),
        :podfile_path => (
          self.parse_argument(argv, "--podfile") \
          or "Podfile.lock"
        ),
      )
    end

    def self.help
      puts "Usage: cocoacache [save|restore]"
    end

    def self.parse_argument(argv, name)
      index = argv.index(name)
      if index.nil?
        return nil
      end

      value = argv[index + 1]
      if value.nil? or value.start_with?('--')
        raise Exception("[!] Insufficient value for option '#{name}'".red)
      end

      return value
    end
  end
end
