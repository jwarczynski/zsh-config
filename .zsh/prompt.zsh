#!/bin/sh

## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git 
zstyle ':vcs_info:*' enable git 

# setup a hook that runs before every ptompt. 
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

# Measure time functions
_command_time_preexec() {
  export ZSH_COMMAND_TIME=""
  # check excluded
  if [ -n "$ZSH_COMMAND_TIME_EXCLUDE" ]; then
    cmd="$1"
    for exc ($ZSH_COMMAND_TIME_EXCLUDE) do;
      if [ "$(echo $cmd | grep -c "$exc")" -gt 0 ]; then
        # echo "command excluded: $exc"
        return
      fi
    done
  fi

  PRE_EXEC_TIMER=$(date +%s.%N)
}

_command_time_precmd() {
  if [ $PRE_EXEC_TIMER ]; then
    local elapsed=$(($(date +%s.%N) - $PRE_EXEC_TIMER))
    #if (( $elapsed > 0.25 )); then
      if (( $elapsed > 60 )); then
        export ZSH_COMMAND_TIME="%F{blue}[%f%F{white}$(printf '%dm %.2fs' $(($elapsed / 60)) $(($elapsed % 60)) )%f%F{blue}]%f"
      elif (( $elapsed > 1 )); then
        export ZSH_COMMAND_TIME="%F{blue}[%f%F{white}$(printf '%.3fs' $elapsed)%f%F{blue}]%f"
      else
        export ZSH_COMMAND_TIME="%F{blue}[%f%F{white}$(printf '%3d ms' $(($elapsed * 1000)) )%f%F{blue}]%f"
      fi
    #fi
    unset PRE_EXEC_TIMER
  fi
}

precmd_functions+=(_command_time_precmd)
preexec_functions+=(_command_time_preexec)

# Exclude some commands
export ZSH_COMMAND_TIME_EXCLUDE=(vim nvim man less more ssh mcedit)
export ZSH_COMMAND_TIME=""


local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"
# Add basic begining, username and hostname
PROMPT="%B%F{blue}┬%f%b"
# Add username
PROMPT+="%B%F{blue}(%f%(!.%F{red}.%F{green})%n%f"
# Separator
PROMPT+="%F{magenta}@%f"
# Hostname
PROMPT+="%F{white}%M%f%F{blue})%f%b"

# Show how many jobs are open
PROMPT+="%(1j:%F{blue} [%f%F{white}%j%f%F{blue}]%f:)"

# Add git info (this is variable!)
PROMPT+="\${vcs_info_msg_0_}"

# Current path
PROMPT+="-${blue_op}%B%F{cyan}%~%f%b%E${blue_cp} "$'\n'

# Add new line for new command to be written
PROMPT+="%F{blue}└%f"
# Add time elapsed if more than 0.25s (this is variable!)
PROMPT+="\${ZSH_COMMAND_TIME}"

PROMPT+="-%F{blue}[%f%(?.%F{green}✔%?.%F{red}✘%?)%f%F{blue}]%f "

# Does prompt has privs
PROMPT+="%F{white}%(!:#:)%f"

# Ending part with green/red arrow.
PROMPT+="%B%(?:%F{green}:%F{red}) ➜ %f%b"

# Taken from Tassilo's Blog
# https://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/

#local path_p="${blue_op}%F{cyan}%~%f${blue_cp}"
#local user_host="${blue_op}%n@%m${blue_cp}"
#local ret_status="${blue_op}%(?.%F{green}√%?.%F{red}?%?)%f${blue_cp}"
#local hist_no="${blue_op}%h${blue_cp}"
#local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
#PROMPT="╭─${path_p}─${ret_status}─${hist_no}
#╰─${blue_op}${pr_exec_time}${blue_cp}-${blue_op}${smiley}${blue_cp} %{$fg_bold[green]%} ➜ %f"
#local cur_cmd="${blue_op}%_${blue_cp}"
#PROMPT2="${cur_cmd}> "
