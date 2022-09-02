.DEFAULT_GOAL := dist

.PHONY: dist
dist: assemble
	csso -i dist/plistico.css -o dist/plistico.min.css

.PHONY: assemble
assemble:
	cat src/vars.css > dist/plistico.css
	cat src/elements.css >> dist/plistico.css
	cat src/navbar.css >> dist/plistico.css
	cat src/grid.css >> dist/plistico.css

	if [ -f src/custom-vars.css ]; then \
		cat src/custom-vars.css >> dist/plistico.css; \
	fi
