{ config, pkgs, ... }:

{
  programs.tmux = { enable = true;
    extraConfig = ''
# vim
#set-window-option -g mode-keys vi
# colors
# Ctrl- a
unbind C-b
set -g prefix C-Space
#Mouse mode
set -g mouse on
# Toggle mouse off with ^B M
# remove 0
set -g base-index 1
set -sg escape-time 50
setw -g pane-base-index 1
# Status update interval
set -g status-interval 1

bind-key -n M-h resize-pane -R 5

set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
# Basic status bar colors
# Left side of status bar
# 
# # Right side of status bar
# set -g status-right-bg black
# set -g status-right-fg cyan
# 
# # Window status
# 
# # Current window status
# set -g window-status-current-bg red
# set -g window-status-current-fg black
# 
# # Window with activity status
# set -g window-status-activity-bg yellow # fg and bg are flipped here due to a
# set -g window-status-activity-fg black  # bug in tmux
# 
# # Pane border
# set -g pane-border-bg default
# set -g pane-border-fg default
# 
# # Active pane border
# set -g pane-active-border-bg default
# set -g pane-active-border-fg green
# 
# # Pane number indicator
# set -g display-panes-colour default
# set -g display-panes-active-colour default
# 
# # Clock mode
# set -g clock-mode-colour red
# set -g clock-mode-style 24
# 
# # Message
# set -g message-bg default
# set -g message-fg default
# 
# # Command message
# set -g message-command-bg default
# set -g message-command-fg default
# 
# # Mode
# set -g mode-bg red
# set -g mode-fg default

set -g remain-on-exit on
#copy to clipboard
bind -T copy-mode-vi y send -X copy-pipe "xclip -selection c"
#auto reorder
set-option -g renumber-windows on

# Give newly created project sessions the same initial layout as general.  The
# general session is bootstrapped by Fish instead, so it is deliberately exempt.
set-hook -g session-created 'if-shell -F "#{!=:#{hook_session_name},general}" "new-window -d -t :2 -n window2"'
set-hook -ag session-created 'if-shell -F "#{!=:#{hook_session_name},general}" "new-window -d -t :3 -n window3"'
set-hook -ag session-created 'if-shell -F "#{!=:#{hook_session_name},general}" "new-window -d -t :4 -n window4"'
set-hook -ag session-created 'if-shell -F "#{!=:#{hook_session_name},general}" "new-window -d -t :5 -n window5"'


# Split horizontally on the first split, and vertically on subsequent splits
bind-key -n M-n if-shell "test $(tmux list-panes | wc -l) -eq 1" "split-window -h" "split-window -v"

# Swap current pane with the first pane in the next window
bind-key -n M-i swap-pane -s "$TMUX_PANE" -t 1

# Resize pane to make it smaller
bind-key -n M-- resize-pane -U 5

# Resize pane to make it larger
bind-key -n M-= resize-pane -D 5

## DWM
# move and resize
unbind -n Tab
bind-key -n M-h resize-pane -L 5
bind-key -n M-l resize-pane -R 5
bind-key -T prefix C-l select-pane -R
bind-key -n M-j select-pane -t :.+
bind-key -n M-k select-pane -t :.-
# DWM-style direct window selection. Window numbering starts at 1.
bind-key -n M-1 select-window -t :1
bind-key -n M-2 select-window -t :2
bind-key -n M-3 select-window -t :3
bind-key -n M-4 select-window -t :4
bind-key -n M-5 select-window -t :5
# Show the session chooser (equivalent to the default prefix + s binding).
bind-key -n M-w choose-tree -Zs
# Swap current pane with the first pane in the next window
bind-key -n C-i swap-pane -s "$TMUX_PANE" -t 0
# Close the current pane, except for pane 0
bind-key -n M-c if-shell "test $(tmux display-message -p '#{pane_index}') -ne 1" "run 'tmux kill-pane'" "display-message 'Cannot close pane 1'"
# Close the current window, but keep the session alive by preserving its last window.
bind-key -n M-C if-shell -F '#{==:#{session_windows},1}' 'display-message "Cannot close the last window"' 'kill-window'
unbind-key -n Tab

# Set the colors for the highlighted and non-highlighted parts
set -g status-style 'bg=default,fg=white'
set -g window-status-style 'bg=default,fg=white'
set -g window-status-current-style 'bg=red,fg=black'

# Customize the status-right and status-left options
set -g status-left '#[bg=blue] #S #[default]'
set -g status-right '#[bg=blue] #(date "+%H:%M") #[default]'
bind Tab display-popup -E "tms"

#titles
set-window-option -g window-status-current-format "[#I:#T]"
set-window-option -g window-status-format "[#I:#T]"
      '';
  };
}
