function fish_greeting
    set -l fonts isometric1 isometric2 isometric3 isometric4
    figlet -w120 -f (random choice $fonts) TheUtz | lolcat
end
