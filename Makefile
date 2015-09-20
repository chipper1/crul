VERSION=0.3.1
ZIPNAME=crul-$(VERSION)-$(shell uname -m -s|tr '[:upper:] ' '[:lower:]-').zip

all: spec build

.PHONY: spec
spec:
	crystal spec

build: crul

crul: crul.cr src/*.cr src/formatters/*.cr
	crystal build --release crul.cr
	@du -sh crul

release: spec $(ZIPNAME)

$(ZIPNAME): crul LICENSE.txt
	@zip $@ crul LICENSE.txt > /dev/null
	@du -sh $@

clean:
	rm -rf .crystal crul *.zip .deps libs

PREFIX ?= /usr/local

install: crul
	install -d $(PREFIX)/bin
	install crul $(PREFIX)/bin
