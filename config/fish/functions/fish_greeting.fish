function fish_greeting
    set -l greeting neofetch figlet
    set -l fonts isometric1 isometric2 isometric3 isometric4

    switch (random choice $greeting)
        case neofetch
            neofetch
        case figlet
            figlet -w120 -f (random choice $fonts) TheUtz | lolcat
    end
end
