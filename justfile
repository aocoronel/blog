build:
  zola build

release: build
  rsync -av --delete --exclude='LICENSE' --exclude='.git' public/ ~/dev/github/aocoronel.github.io/
  git -C ~/dev/github/aocoronel.github.io/ commit -a --amend
  git -C ~/dev/github/aocoronel.github.io/ push -f
