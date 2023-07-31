#
# Extra path
#
export PATH=$HOME/.local/bin:$PATH

#
# Aliases and custom command
#
alias l='ls -lha --color auto'
jnote () {
  jupyter-notebook --ip="0.0.0.0" --NotebookApp.token="" --NotebookApp.password="" --no-browser
}
alias unsafe-jupyter-notebook='jnote'

#
# Custom binding
#
stty werase undef
bind "\C-w:unix-filename-rubout"
# export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
