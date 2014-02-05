.PHONY : all test unit-test ecukes

EMACS ?= emacs
SRC = $(filter-out %-pkg.el, $(wildcard *.el reporters/*.el))
ELC = $(SRC:.el=.elc)
CASK ?= cask
PKG_DIR := $(shell $(CASK) package-directory)
FEATURES = $(wildcard features/*.feature)
VERSION = 0.7.1
TARGET_DIR = shebang-$(VERSION)

all: test

test: 
	$(MAKE) unit-test
	$(MAKE) ecukes

unit-test:
	$(CASK) exec ert-runner

$(PKG_DIR):
	Cask
	$(CASK) install
	touch $@

ecukes:
	$(CASK) exec ecukes --reporter magnars --script $(FEATURES) --no-win

marmalade:
	mkdir $(TARGET_DIR)
	cp shebang.el $(TARGET_DIR)
	cp README.md $(TARGET_DIR)
	cp shebang-pkg.el $(TARGET_DIR)
	tar -cf shebang-$(VERSION).tar $(TARGET_DIR)
	rm -rI shebang-$(VERSION).tar
	rm -rI $(TARGET_DIR)
