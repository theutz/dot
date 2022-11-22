function tmuxl --wraps='tmux list-essions' --wraps='tmux list-sessions' --description 'alias tmuxl tmux list-sessions'
  tmux list-sessions $argv; 
end
