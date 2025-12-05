.PHONY: dev
dev:
	@hugo serve -D

.PHONY: new
new:
	@hugo new content content/posts/$(NAME)/index.md
