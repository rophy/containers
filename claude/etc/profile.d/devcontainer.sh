# Prompt
set_prompt() {
    if [ $? -eq 0 ]; then
        COLOR="\[\e[32m\]" # Green for success
    else
        COLOR="\[\e[31m\]" # Red for error
    fi
    PS1="${COLOR}\u@DEVCONTAINER\[\e[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ "
}
PROMPT_COMMAND=set_prompt

# Enable bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Common aliases
alias claude="claude --dangerously-skip-permissions"
alias happy="happy --dangerously-skip-permissions"

