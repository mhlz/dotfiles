## Set the tmux window title, depending on whether we are running something, or just prompting 
#function fish_title 
#    if [ "fish" != $_ ] 
#        tmux rename-window "$_ $argv" 
#    else 
#        tmux_directory_title 
#    end 
#end
#
#function tmux_directory_title 
#    if [ "$PWD" != "$LPWD" ] 
#        set LPWD "$PWD"
#        set INPUT $PWD
#        set SUBSTRING (eval echo $INPUT| awk '{ print substr( $0, length($0) - 19, length($0) ) }') 
#        tmux rename-window "..$SUBSTRING" 
#    end
#end 
#
