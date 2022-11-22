function gws --wraps='git status --short' --description 'alias gws git status --short'
    git status --short $argv
end

function gwS --wraps='git status' --description 'alias gws git status'
    git status $argv
end
