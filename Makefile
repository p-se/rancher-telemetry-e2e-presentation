main: build

build:
	docker run --rm -it \
		-v $$(pwd):/data \
		--user=1000 \
		minlag/mermaid-cli \
			-i e2e-testing.md -o e2e-testing-stable.md
	sed -i 's/!\[diagram\]/!\[bg height:80%\]/g' e2e-testing-stable.md

autobuild:
	@echo In progress

pdf: build
	marp --pdf --allow-local-files e2e-testing-stable.md

html: build
	marp --html e2e-testing-stable.md

all: build
	marp --html --pdf --allow-local-files e2e-testing-stable.md

serve:
	marp -s .
