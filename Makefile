@all: clean build uninstall install

clean:
	rm -f cocoacache-*.gem

build:
	gem build cocoacache.gemspec

uninstall:
	gem uninstall cocoacache --all --executables 2>/dev/null

install:
	gem install cocoacache-*.gem

push: clean build
	gem push cocoacache-*.gem
