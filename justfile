build:
  zola build

release: build
  rsync -av --update public/ ~/dev/github/aocoronel.github.io/
  git -C ~/dev/github/aocoronel.github.io/ commit --amend
  git -C ~/dev/github/aocoronel.github.io/ push -f
