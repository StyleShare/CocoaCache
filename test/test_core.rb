require "digest"
require "minitest/autorun"

require_relative "../lib/cocoacache"
require_relative "helper"

class CoreTest < Minitest::Test

  def setup()
    @fixture_directory = "#{Dir.pwd}/test/fixtures"

    cleanup_fixtures()
    prepare_fixture("OriginSpecs")

    @core = CocoaCache::Core.new(
      :origin_specs_dir => File.join(@fixture_directory, "OriginSpecs"),
      :cache_specs_dir => File.join(@fixture_directory, "CacheSpecs"),
      :podfile_path => File.join(@fixture_directory, "Podfile.lock")
    )
    @core.mute = true
  end

  def teardown
    cleanup_fixtures()
  end

  def prepare_fixture(name)
    archive = "#{@fixture_directory}/#{name}.zip"
    destination = @fixture_directory
    exclude = "__MACOSX/*"
    `unzip -qq -o #{archive} -d #{destination} -x #{exclude} 2>/dev/null`
  end

  def cleanup_fixtures
    return if @fixture_directory.nil?
    return unless @fixture_directory.include? "CocoaCache"
    `find #{@fixture_directory}/* -type d -maxdepth 0 | xargs rm -r`
  end

  def test_save()
    # when
    @core.save()

    # then
    assert_file_exist fixture_path("CacheSpecs/d/a/2/Alamofire")
    assert_file_exist fixture_path("CacheSpecs/a/a/6/Kingfisher")
    assert_file_exist fixture_path("CacheSpecs/8/a/7/Moya")
    assert_file_exist fixture_path("CacheSpecs/d/c/d/Nimble")
    assert_file_exist fixture_path("CacheSpecs/8/0/9/Quick")
    assert_file_exist fixture_path("CacheSpecs/7/7/7/ReactorKit")
    assert_file_exist fixture_path("CacheSpecs/3/c/1/RxCocoa")
    assert_file_exist fixture_path("CacheSpecs/2/e/c/RxSwift")
    assert_file_exist fixture_path("CacheSpecs/8/5/5/RxTest")
    assert_file_exist fixture_path("CacheSpecs/1/f/6/SnapKit")
    assert_file_exist fixture_path("CacheSpecs/2/b/9/Stubber")
    assert_file_exist fixture_path("CacheSpecs/a/3/e/Texture")
    assert_file_exist fixture_path("CacheSpecs/d/4/8/Then")
    assert_file_exist fixture_path("CacheSpecs/8/9/0/URLNavigator")
  end

  def test_restore()
    # given
    @core.save()
    FileUtils.rm_rf fixture_path("OriginSpecs/d/a/2/Alamofire")
    FileUtils.rm_rf fixture_path("OriginSpecs/7/7/7/ReactorKit/2.0.0")
    FileUtils.rm_rf fixture_path("OriginSpecs/7/7/7/ReactorKit/2.0.1")
    FileUtils.rm_rf fixture_path("OriginSpecs/1/f/6/SnapKit/5.0.0")

    # when
    @core.restore()

    # then
    assert_file_exist fixture_path("OriginSpecs/d/a/2/Alamofire")
    assert_file_exist fixture_path("OriginSpecs/7/7/7/ReactorKit/2.0.0")
    assert_file_exist fixture_path("OriginSpecs/7/7/7/ReactorKit/2.0.1")
    assert_file_exist fixture_path("OriginSpecs/1/f/6/SnapKit/5.0.0")
  end

  def fixture_path(path)
    return File.join(@fixture_directory, path)
  end
end


def assert_file_exist(path)
  assert File.exist?(path), "Expected #{path} to exist but not."
end
