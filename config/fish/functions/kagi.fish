function kagi
    set -l query (string escape --style=url (string join " " $argv))
    open "https://kagi.com?q=$query"
end
