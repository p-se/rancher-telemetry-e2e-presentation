main: build

# Want's to be called manually on change of diagrams to speed
# up the build process of everything else.
diagrams:
	for file in images/diagrams/*.mmd; do \
		echo "Building $$file"; \
		docker run --rm -it \
			-v $$(pwd):/data \
			--user=1000 \
			minlag/mermaid-cli \
				-i $${file} -o images/diagrams/$$(basename $${file} .mmd).svg; \
	done

build:
	for file in *.md; do \
		echo "Building $$file"; \
		marp --allow-local-files $$file; \
	done

pdf: build
	for file in *.md; do \
		echo "Building $$file"; \
		marp --pdf --allow-local-files $$file; \
	done

html: build
	for file in *.md; do \
		echo "Building $$file"; \
		marp --html $$file; \
	done

all: build diagrams
	for file in *.md; do \
		echo "Building $$file"; \
		marp --html --pdf --allow-local-files $$file; \
	done

serve: build
	marp -s .

soft-clean:
	rm -f *.pdf *.html *.png *.svg

clean: soft-clean
	find images/diagrams -type f -name '*.svg' -delete
