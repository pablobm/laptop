if status is-interactive
    # Commands to run in interactive sessions can go here
end

switch (uname)
  case Darwin
    set -p PATH /opt/homebrew/bin
end
set -p PATH "$HOME/bin"

zoxide init fish | source
