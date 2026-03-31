# Custom Functions

# Mkdir and cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Git add, commit, push
lazygit-push() {
    git add .
    git commit -m "$1"
    git push
}
