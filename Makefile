SHELL = bash
.DEFAULT_GOAL := all

.PHONY: all
all: glue variants minify docs end

.PHONY: glue
glue:
	@echo
	@echo "--> Gluing together CSS into one file."
	cat src/vars.css > dist/plistico.css
	cat src/elements.css >> dist/plistico.css
	cat src/navbar.css >> dist/plistico.css
	cat src/grid.css >> dist/plistico.css

	if [ -f src/custom-vars.css ]; then \
		cat src/custom-vars.css >> dist/plistico.css; \
	fi

.PHONY: variants
variants: glue
	@echo
	@echo "--> Generate no vars CSS file."
	node_modules/.bin/postcss dist/plistico.css -o dist/plistico-no-vars.css

.PHONY: minify
minify:
	@echo
	@echo "--> Minifying CSS files."
	node_modules/.bin/csso -i dist/plistico.css -o dist/plistico.min.css
	echo "\n" >> dist/plistico.min.css
	node_modules/.bin/csso -i dist/plistico-no-vars.css -o dist/plistico-no-vars.min.css
	echo "\n" >> dist/plistico-no-vars.min.css

.PHONY: docs
docs:
	@echo
	@echo "--> Updating docs."
	sed '/start-css/,/end-css/{//!d;}' docs/index.html > docs/tmp.html
	sed '/start-css/r dist/plistico.min.css' docs/tmp.html > docs/index.html
	rm docs/tmp.html

.PHONY: end
end:
	@echo
	@echo "--> Done."
	@echo
