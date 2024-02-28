# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
bindkey -v
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/keroles/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' ('$branch')'
  fi
}

setopt prompt_subst
prompt='%{%F{cyan}%}%n@%m:%~/$(git_branch_name) > '

# Command not found
source /usr/share/doc/pkgfile/command-not-found.zsh
# Auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Auto compiletions
#source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# History substring search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Transferable
source ~/.transferable/.envs
source ~/.transferable/.variables
source ~/.transferable/.aliases
source ~/.transferable/.shell_app_config
