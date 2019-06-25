# CocoaCache

[![Gem](https://img.shields.io/gem/v/cocoacache.svg)](https://rubygems.org/gems/cocoacache)
[![Build Status](https://travis-ci.org/devxoul/CocoaCache.svg?branch=master)](https://travis-ci.org/devxoul/CocoaCache)
[![Codecov](https://img.shields.io/codecov/c/github/devxoul/CocoaCache.svg)](https://codecov.io/gh/devxoul/CocoaCache)

Partial CocoaPods Specs cache for the faster CI build.

## Background

It takes several minutes updating CocoaPods Specs repository while building a project on a CI server. In order to prevent from updating Specs repository, you have to cache the entire Specs repository located in `~/.coccoapods/repos/master`. But this is too large to cache in the CI server. CocoaCache helps to cache specific Pod specs to prevent from updating the Specs repository.

## Concepts

![CocoaCache](https://user-images.githubusercontent.com/931655/60092486-1aa3dd00-9782-11e9-9afe-6e4cb8933e9e.png)

### Saving Cache (Previous Build)

1. Find Pods from `Podfile.lock` to cache.
2. Copy the specific Specs from the origin Specs directory to `./Specs`.
   ```
   $HOME/.cocoapods/repos/master/Specs/7/7/7/ReactorKit -> ./Specs/7/7/7/ReactorKit
   ```
3. Cache `./Specs` to the CI server.

### Restoring Cache (Next Build)

1. Restore the `./Spec` directory from the CI server.
2. Find Pods from `Podfile.lock` to restore.
3. Copy the cached Specs back to the origin Specs directory from `./Specs`.
   ```
   ./Specs/7/7/7/ReactorKit -> $HOME/.cocoapods/repos/master/Specs/7/7/7/ReactorKit
   ```

## Installation

```console
$ gem install cocoacache
```

## Usage

```
Usage: cocoacache COMMAND [options]

Commands:
  save        Copy specs from the origin Specs to cache directory.
  restore     Copy the cached Specs back to the origin directory.

Options:
  --origin <value>    The origin Specs directory. Defaults to $HOME/.cocoapods/repos/master/Specs
  --cache <value>     Where to cache the Specs. Defaults to ~/Specs
  --podfile <value>   The path for the Podfile.lock. Defaults to ~/Podfile.lock
```

## Configuration

### Travis

**`.travis.yml`**

```yml
cache:
  - directories:
    - Specs

install:
  - gem install cocoacache && cocoacache restore
  - pod install

before_cache:
  - cocoacache save
```

## License

**CocoaCache** is under MIT license. See the [LICENSE] file for more info.
