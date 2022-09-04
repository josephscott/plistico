SHELL=bash
.DEFAULT_GOAL := all

.PHONY:
all: dist docs

.PHONY: docs
docs:

.PHONY: dist
dist: assemble
	node_modules/.bin/csso -i dist/plistico.css -o dist/plistico.min.css
	node_modules/.bin/postcss dist/plistico.css -o dist/plistico-no-vars.css
	node_modules/.bin/csso -i dist/plistico-no-vars.css -o dist/plistico-no-vars.min.css

.PHONY: assemble
assemble:
	cat src/vars.css > dist/plistico.css
	cat src/elements.css >> dist/plistico.css
	cat src/navbar.css >> dist/plistico.css
	cat src/grid.css >> dist/plistico.css

	if [ -f src/custom-vars.css ]; then \
		cat src/custom-vars.css >> dist/plistico.css; \
	fi
