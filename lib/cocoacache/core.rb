require "yaml"

module CocoaCache
  class Core
    attr_accessor :mute

    def initialize(origin_specs_dir:, cache_specs_dir:, podfile_path:)
      @origin_specs_dir = origin_specs_dir
      @cache_specs_dir = cache_specs_dir
      @podfile_path = podfile_path
    end

    def save()
      pods = get_pods()
      pods.each do |pod|
        origin_path = get_origin_path(pod)
        cache_path = get_cache_path(pod)
        copy_dir(:from => origin_path, :to => cache_path)
      end
    end

    def restore()
      pods = get_pods()
      pods.each do |pod|
        origin_path = get_origin_path(pod)
        cache_path = get_cache_path(pod)
        copy_dir(:from => cache_path, :to => origin_path)
      end
    end

    def copy_dir(from:, to:)
      log "Copy #{from} -> #{to}"
      `mkdir -p #{to} && cp -R #{from} #{to}/../`
    end

    def get_pods()
      lockfile = YAML.load(File.read(@podfile_path))
      pods = lockfile["SPEC REPOS"]["https://github.com/cocoapods/specs.git"]
      return pods
    end

    def get_origin_path(pod)
      return File.join(@origin_specs_dir, *get_shard_prefixes(pod), pod)
    end

    def get_cache_path(pod)
      return File.join(@cache_specs_dir, *get_shard_prefixes(pod), pod)
    end

    def get_shard_prefixes(pod)
      return Digest::MD5.hexdigest(pod)[0...3].split("")
    end

    def log(*strings)
      puts strings.join(" ") if not @mute
    end
  end
end
