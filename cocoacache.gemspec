require_relative "lib/cocoacache/version"
require "date"

Gem::Specification.new do |s|
  s.name        = "cocoacache"
  s.version     = CocoaCache::VERSION
  s.date        = Date.today
  s.summary     = "Partial CocoaPods Specs cache for the faster CI build"
  s.description = "Partial CocoaPods Specs cache for the faster CI build. It "\
                  "helps to cache specific Pod specs to prevent from updating"\
                  "the Specs repository."
  s.authors     = ["Suyeol Jeon"]
  s.email       = "devxoul@gmail.com"
  s.files       = ["lib/cocoacache.rb"]
  s.homepage    = "https://github.com/devxoul/CocoaCache"
  s.license     = "MIT"

  s.files = Dir["lib/**/*.rb"] + %w{ bin/cocoacache README.md LICENSE }

  s.executables   = %w{ cocoacache }
  s.require_paths = %w{ lib }

  s.add_runtime_dependency "colored2", "~> 3.1"

  s.required_ruby_version = ">= 2.2.2"
end
