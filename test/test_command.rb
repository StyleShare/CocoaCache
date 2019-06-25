require "minitest/autorun"
require "rspec/mocks/minitest_integration"

require_relative "../lib/cocoacache"
require_relative "helper"

class CommandTest < Minitest::Test

  def setup()
    @core = instance_spy(CocoaCache::Core)
    @factory = class_spy(CocoaCache::Core, :new => @core)
  end

  def test_save()
    # when
    CocoaCache::Command.run(@factory, ["save"])

    # then
    expect(@core).to have_received(:save)
    expect(@core).to_not have_received(:restore)
  end

  def test_save_with_no_arguments__uses_defaults()
    # when
    CocoaCache::Command.run(@factory, ["save"])

    # then
    expect(@factory).to have_received(:new).with(
      :origin_specs_dir => "$HOME/.cocoapods/repos/master/Specs",
      :cache_specs_dir => "Specs",
      :podfile_path => "Podfile.lock",
    )
  end

  def test_save_with_arguments()
    # when
    CocoaCache::Command.run(@factory, [
        "save",
        "--origin", "/awesome/path/to/MyOriginSpecs",
        "--cache", "/superb/path/to/MyCacheSpecs",
        "--podfile", "/wonderful/path/to/MyPodfile",
    ])

    # then
    expect(@factory).to have_received(:new).with(
      :origin_specs_dir => "/awesome/path/to/MyOriginSpecs",
      :cache_specs_dir => "/superb/path/to/MyCacheSpecs",
      :podfile_path => "/wonderful/path/to/MyPodfile",
    )
  end

  def test_save_with_insufficient_arguments()
    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "save",
          "--origin",
          "--cache", "/superb/path/to/MyCacheSpecs",
          "--podfile", "/wonderful/path/to/MyPodfile",
      ])
    end

    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "save",
          "--origin", "/awesome/path/to/MyOriginSpecs",
          "--cache",
          "--podfile", "/wonderful/path/to/MyPodfile",
      ])
    end

    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "save",
          "--origin", "/awesome/path/to/MyOriginSpecs",
          "--cache", "/superb/path/to/MyCacheSpecs",
          "--podfile"
      ])
    end
  end

  def test_restore()
    # when
    CocoaCache::Command.run(@factory, ["restore"])

    # then
    expect(@core).to have_received(:restore)
    expect(@core).to_not have_received(:save)
  end

  def test_restore_with_no_arguments__uses_defaults()
    # when
    CocoaCache::Command.run(@factory, ["restore"])

    # then
    expect(@factory).to have_received(:new).with(
      :origin_specs_dir => "$HOME/.cocoapods/repos/master/Specs",
      :cache_specs_dir => "Specs",
      :podfile_path => "Podfile.lock",
    )
  end

  def test_restore_with_arguments()
    # when
    CocoaCache::Command.run(@factory, [
        "restore",
        "--origin", "/awesome/path/to/MyOriginSpecs",
        "--cache", "/superb/path/to/MyCacheSpecs",
        "--podfile", "/wonderful/path/to/MyPodfile",
    ])

    # then
    expect(@factory).to have_received(:new).with(
      :origin_specs_dir => "/awesome/path/to/MyOriginSpecs",
      :cache_specs_dir => "/superb/path/to/MyCacheSpecs",
      :podfile_path => "/wonderful/path/to/MyPodfile",
    )
  end

  def test_restore_with_insufficient_arguments()
    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "restore",
          "--origin",
          "--cache", "/superb/path/to/MyCacheSpecs",
          "--podfile", "/wonderful/path/to/MyPodfile",
      ])
    end

    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "restore",
          "--origin", "/awesome/path/to/MyOriginSpecs",
          "--cache",
          "--podfile", "/wonderful/path/to/MyPodfile",
      ])
    end

    assert_raises Exception do
      CocoaCache::Command.run(@factory, [
          "restore",
          "--origin", "/awesome/path/to/MyOriginSpecs",
          "--cache", "/superb/path/to/MyCacheSpecs",
          "--podfile"
      ])
    end
  end
end
