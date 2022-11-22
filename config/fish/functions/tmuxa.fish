function tmuxa --wraps='tmux new-session -A' --description 'alias tmuxa tmux new-session -A'
  tmux new-session -A $argv; 
end
