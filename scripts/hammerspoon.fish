#!/usr/bin/env fish

set -l spoons_dir ~/.hammerspoon/Spoons
set -l spoon_installer "SpoonInstall.spoon.zip"

if not test -d "$spoons_dir"
    mkdir -p "$spoons_dir"
end

cd "$spoons_dir"

curl --location "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/$spoon_installer" --output "$spoon_installer"

unzip -o "$spoon_installer"
and trash "$spoon_installer"
