.DEFAULT_GOAL := dist

.PHONY: dist
dist: assemble
	csso -i dist/plistico.css -o dist/plistico.min.css

.PHONY: assemble
assemble:
	cat src/vars.css > dist/plistico.css
