.PHONY: push

CURRENT_BRANCH_NAME := $(shell git symbolic-ref --short HEAD)

add:
	git add .

commit: add
	git-cz

rebase-main: commit
	git pull --rebase origin main

push:
	git push --force-with-lease origin $(CURRENT_BRANCH_NAME)

release-dev: 
	gh release create 2.0.100-beta.6 --notes "release dev" --target shl/parse --title "Release dev" --prerelease

roll-back-dev:
	git reset --soft HEAD~1
	git restore --staged publish.yaml
	git restore publish.yaml